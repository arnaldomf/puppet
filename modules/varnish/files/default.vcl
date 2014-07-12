backend default {
    .host = "wordpress-01.example.com";
    .port = "80";
}

sub vcl_recv {
  if(!(req.url ~ "wp-(login|admin)")) {
    unset req.http.cookie;
  }
}
sub vcl_fetch {
  if(!(req.url ~ "wp-(login|admin)")) {
    unset beresp.http.cookie;
    set beresp.ttl = 3600 s;
    return(deliver);
  }
}
