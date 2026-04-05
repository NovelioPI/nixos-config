# apps.nix - Common GUI applications
{self, inputs, ...}: 

{
  flake.nixosModules.apps = { pkgs, lib, ... }: 
  
  {
    environment.systemPackages = with pkgs; [
      # You can remove or add apps as you like
      obsidian
      google-chrome
      discord
      slack
      libreoffice

      foliate               # The best modern EPUB reader (clean UI, TTS, notes)
      calibre               # The "Swiss Army Knife" for ebook library management
      logseq                # Privacy-first, local-only knowledge base (great Obsidian alternative)
      super-productivity    # To-do list, time tracker, and task manager in one
      fclones               # Efficient duplicate file finder (keeps your storage clean)
      xclip                 # Command line interface to the X11 clipboard
      libnotify             # Desktop notifications tool (used by many scripts)
    ];
  };
}