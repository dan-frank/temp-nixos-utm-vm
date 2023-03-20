{
  imports = [
    ( builtins.fetchTarball "https://github.com/hercules-ci/hercules-ci-agent/archive/stable.tar.gz"
      + "/module.nix"
    )
  ];

  services.hercules-ci-agent.enable = true;
  services.hercules-ci-agent.settings.concurrentTasks = 12;
  systemd.services.hercules-ci-agent.environment.HAVE_NT_DATA_SCIENCE_CREDENTIALS = "1";
}
