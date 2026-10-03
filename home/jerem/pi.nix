{ config, pkgs, lib, ... }:

let
  agentDir = "${config.home.homeDirectory}/.pi/agent";
  settings = pkgs.writeText "pi-settings.json" (builtins.toJSON {
    defaultProvider = "ollama";
    defaultModel = "qwen3:4b";
    defaultThinkingLevel = "off";
    compaction = {
      reserveTokens = 4096;
      keepRecentTokens = 8192;
    };
    enableInstallTelemetry = false;
  });
  models = pkgs.writeText "pi-models.json" (builtins.toJSON {
    providers.ollama = {
      baseUrl = "http://127.0.0.1:11434/v1";
      api = "openai-completions";
      apiKey = "ollama";
      models = [{
        id = "qwen3:4b";
        name = "Qwen3 4B (local)";
        reasoning = true;
        input = [ "text" ];
        cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; };
        contextWindow = 32768;
        maxTokens = 4096;
      }];
    };
  });
in
{
  home.packages = [ pkgs.pi-coding-agent ];

  home.activation.piConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.coreutils}/bin/install -d -m 0700 ${lib.escapeShellArg agentDir}
    if [[ ! -e ${lib.escapeShellArg "${agentDir}/settings.json"} && ! -L ${lib.escapeShellArg "${agentDir}/settings.json"} ]]; then
      run ${pkgs.coreutils}/bin/install -m 0600 ${settings} ${lib.escapeShellArg "${agentDir}/settings.json"}
    fi
    if [[ ! -e ${lib.escapeShellArg "${agentDir}/models.json"} && ! -L ${lib.escapeShellArg "${agentDir}/models.json"} ]]; then
      run ${pkgs.coreutils}/bin/install -m 0600 ${models} ${lib.escapeShellArg "${agentDir}/models.json"}
    fi
  '';
}