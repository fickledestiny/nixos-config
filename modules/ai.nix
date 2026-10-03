{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cpu;
    host = "127.0.0.1";
    port = 11434;
    openFirewall = false;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "32768";
      OLLAMA_NUM_PARALLEL = "1";
      OLLAMA_KEEP_ALIVE = "2m";
    };
  };
}