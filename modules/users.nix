{pkgs, ...}: {
  users.users = {
    fabian = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.fish;
      hashedPassword = "$y$j9T$VD24kXE3Gb0FgnERbMPXP/$FF6Jj9cJA.i9jDcwnvqmdruut4vRyhH6o6.yl7Gncn4";
    };
    andrea = {
      isNormalUser = true;
      shell = pkgs.fish;
      hashedPassword = "$y$j9T$kDqTVtcI0I27MXmIaMY1l.$pkzRHNC6fpUg07MEyeoQtgHRtkV6tlQ8GXnhWUrWZ75";
    };
  };
}
