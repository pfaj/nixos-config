{
 pkgs, 
 ...
}:{
  environment.systemPackages = with pkgs; [
    searxng
  ];
  services.searx = {
    enable = true;


    settings = { 

      general = {
        donation_url = false;
        contact_url = false;
        privacy_policy = false;
        enable_metrics = false;
      };

      server.port = 8888;
      server.bind_address = "0.0.0.0";
      server.secret_key = "wu%GrY4YWlj%er@TlV1NDEVl4hSPuLM9dx0";
    }
    ;
  };

}
