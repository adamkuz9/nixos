{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options = {
    modules.git.enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      diff-so-fancy
    ];
    home-manager.users.adam = {
      programs.git = {
        enable = true;
        settings = {
          user.name = "Adam";
          user.email = "kartofleadama@gmail.com";
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          push.default = "current";
          push.followTags = true;
          pull.default = "current";
          pull.rebase = true;
          rebase.autoStash = true;
          rebase.missingCommitsCheck = "warn";
          log.abrrevCommit = true;
          log.graphColors = "blue,yellow,cyan,magenta,green,red";
          core.compression = 9;
          core.whitespace = "error";
          core.preloadindex = true;
          advice.addEmptyPathspec = false;
          advice.pushNonFastForward = false;
          advice.statusHints = false;
          status.branch = true;
          status.showStash = true;
          status.showUntrackedFiles = "all";
          diff.context = 3;
          diff.renames = "copies";
          diff.interHunkContext = 10;
          pager.diff = "diff-so-fancy | $PAGER";
          pager.branch = "false";
          pager.tag = "false";
          diff-so-fancy.markEmptyLines = false;
          branch.sort = "-committerdate";
          tag.sort = "-taggerdate";
          color = {
            decorate = {
              HEAD = "red";
              branch = "blue";
              tag = "yellow";
              remoteBrach = "magenta";
            };
            branch = {
              current = "magenta";
              local = "default";
              remote = "yellow";
              upstream = "green";
              plain = "blue";
            };
            diff = {
              meta = "black bold";
              frag = "magenta";
              context = "white";
              whitespace = "yellow reverse";
              old = "red";
            };
          };
          interactive.diffFilter = "diff-so-fancy --patch";
          interactive.singleKey = true;
        };
      };
    };
  };
}
