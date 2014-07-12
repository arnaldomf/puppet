acl purge {
  "localhost";
  "10.0.0.0/16";
}

backend default {
    .host = "wordpress-01.example.com";
    .port = "80";
}

sub vcl_recv {
  if(!(req.url ~ "wp-(login|admin)")) {
    unset req.http.cookie;
  }
  if(req.request == "PURGE") {
    if(!client.ip ~ purge) {
      error 405 "Not allowed.";
    }
    return(lookup);
  }
}
sub vcl_fetch {
  if(!(req.url ~ "wp-(login|admin)")) {
    unset beresp.http.cookie;
    set beresp.ttl = 3600 s;
    return(deliver);
  }
}
sub vcl_hit {
  if(req.request == "PURGE") {
    purge;
    error 200 "Purged.";
  }
}
sub vcl_miss {
  if(req.request == "PURGE") {
    purge;
    error 200 "Purged.";
  }
  
}
