# Hyprland-Dots
Hyprland dots that I use



<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hyprland-Dots README</title>
</head>
<body>
    <h1>🌌 Hyprland-Dots</h1>
    <p>
        Welcome to <strong>Hyprland-Dots</strong>, a minimal yet powerful collection of dotfiles designed for the Hyprland Wayland compositor. These dotfiles bring a modern, functional, and visually stunning desktop experience to your system, with full customization at your fingertips.
    </p>
    <p>
        <img src="./screenshot.png" alt="Screenshot of Hyprland-Dots">
    
    
    <h2>✨ Features</h2>
    <ul>
        <li><strong>Minimalistic UI</strong>: A sleek and clutter-free desktop experience.</li>
        <li><strong>Custom Waybar</strong>: A well-organized and informative status bar.</li>
        <li><strong>Wofi Launcher</strong>: A fast, customizable application launcher.</li>
        <li><strong>Hyprpaper</strong>: Dynamic wallpapers tailored to match your desktop aesthetics.</li>
        <li><strong>Performance Optimizations</strong>: Lightweight and fast, tailored for modern Wayland workflows.</li>
        <li><strong>Theming</strong>: Easily customizable themes, from colors to icons and beyond.</li>
        <li><strong>Multi-Monitor Support</strong>: Ready for multiple displays with easy configuration.</li>
    </ul>
    
    <h2>🚀 Quick Start</h2>
    
    <h3>Prerequisites</h3>
    <p>
        Before diving in, make sure you have the following installed:
    </p>
    <ul>
        <li><strong>Hyprland</strong>: A dynamic tiling window manager for Wayland.</li>
        <li><strong>Waybar</strong>: A customizable status bar for Wayland.</li>
        <li><strong>Wofi</strong>: A simple application launcher for Wayland.</li>
        <li><strong>Hyprpaper</strong>: Wallpaper utility for Hyprland.</li>
        <li>Other utilities: <code>kitty</code>, <code>neofetch</code>, <code>picom</code>, etc.</li>
    </ul>
    
    <h3>Installation</h3>
    <ol>
        <li>
            <strong>Clone the repository:</strong>
            <pre><code>git clone https://github.com/yourusername/Hyprland-Dots.git ~/Hyprland-Dots</code></pre>
        </li>
        <li>
            <strong>Backup existing config:</strong>
            <pre><code>mv ~/.config/hypr ~/.config/hypr.bak</pre>
mv ~/.config/waybar ~/.config/waybar.bak
mv ~/.config/wofi ~/.config/wofi.bak</code></pre>
        </li>
        <li>
            <strong>Copy the dotfiles:</strong>
            <pre><code>cp -r ~/Hyprland-Dots/.config/* ~/.config/</code></pre>
        </li>
        <li>
            <strong>Install dependencies:</strong> Use your package manager (<code>dnf</code>, <code>pacman</code>, <code>apt</code>, or <code>flatpak</code>) to install the required dependencies:
            <ul>
                <li><strong>For Fedora:</strong></li>
                <pre><code>sudo dnf install hyprland waybar wofi kitty neofetch picom</code></pre>
                <li><strong>For Arch:</strong></li>
                <pre><code>sudo pacman -S hyprland waybar wofi kitty neofetch picom</code></pre>
            </ul>
        </li>
        <li>
            <strong>Launch Hyprland:</strong>
            Start your Hyprland session via your display manager or from a TTY:
            <pre><code>Hyprland</code></pre>
        </li>
    </ol>
    
    <h2>🔧 Configuration Overview</h2>
    
    <h3>Hyprland Config (<code>~/.config/hypr/hyprland.conf</code>)</h3>
    <p>This is the heart of the system. It's where you configure keybindings, window rules, workspaces, and more. Some cool keybindings in this setup include:</p>
    <ul>
        <li><strong>Alt + Space</strong>: Launches <code>wofi</code>.</li>
        <li><strong>Super + Q</strong>: Closes the focused window.</li>
        <li><strong>Super + Enter</strong>: Launches <code>Kitty</code>.</li>
        <li><strong>Super + Shift + R</strong>: Restarts Hyprland.</li>
    </ul>
    
    <h3>Waybar Config (<code>~/.config/waybar/config</code>)</h3>
    <p>Waybar is your status bar, showing essential system information like:</p>
    <ul>
        <li>Time and Date</li>
        <li>CPU/Memory usage</li>
        <li>Network</li>
        <li>Bluetooth</li>
        <li>Volume control</li>
    </ul>
    <p>Each module can be tweaked in the <code>waybar/config</code> file.</p>
    
    <h3>Wofi Config (<code>~/.config/wofi/config</code>)</h3>
    <p>Wofi is your go-to application launcher. Customize the look and feel by tweaking the <code>.config/wofi/style.css</code> file.</p>
    
    <h3>Hyprpaper (<code>~/.config/hypr/hyprpaper.conf</code>)</h3>
    <p>Hyprpaper handles dynamic wallpapers. Add your favorite images or set it up to rotate wallpapers automatically!</p>
    
    <h2>🎨 Theming</h2>
    <p>One of the best parts of Hyprland-Dots is the extensive theming options. Here's how you can tweak the aesthetics:</p>
    <ul>
        <li><strong>Fonts</strong>: Change the system fonts in <code>~/.config/waybar/style.css</code> and <code>~/.config/wofi/style.css</code>.</li>
        <li><strong>Colors</strong>: Modify the colors in the Hyprland, Waybar, and Wofi configuration files.</li>
        <li><strong>Icons</strong>: Use any icon pack (such as Papirus or Numix). Simply install the icon theme and set it up in your environment.</li>
    </ul>
    <p>To change the theme, update the <code>colors</code> and <code>fonts</code> sections in the configuration files or use tools like <code>lxappearance</code> for GTK theming.</p>
    
    <h2>📷 Screenshots</h2>
    <p>Check out some examples of the Hyprland-Dots setup in action:</p>
    <p><img src="./screenshots/screenshot1.png" alt="Screenshot 1"></p>
    <p><img src="./screenshots/screenshot2.png" alt="Screenshot 2"></p>
    
    <h2>🛠 Troubleshooting</h2>
    
    <h3>Waybar not starting?</h3>
    <p>Make sure Waybar is installed correctly. Try running it manually in the terminal:</p>
    <pre><code>waybar &</code></pre>
    <p>If you see any errors, consult the logs:</p>
    <pre><code>journalctl -xe | grep waybar</code></pre>
    
    <h3>Wofi not launching?</h3>
    <p>Double-check your keybindings in <code>hyprland.conf</code>. Run Wofi manually to test:</p>
    <pre><code>wofi --show drun</code></pre>
    
    <h3>General protection fault with Waybar?</h3>
    <p>Make sure you have the correct versions of <code>libstdc++</code> and Waybar for your system, as outdated or mismatched libraries can cause crashes.</p>
    
    <h2>🌟 Contributing</h2>
    <p>Got ideas or improvements? Feel free to fork the repository, make your changes, and open a pull request. Contributions are always welcome!</p>
    
    <h2>📜 License</h2>
    <p>This project is licensed under the MIT License - see the <a href="./LICENSE">LICENSE</a> file for details.</p>
    
    <h2>🙌 Acknowledgements</h2>
    <ul>
        <li><strong>Hyprland</strong>: The awesome Wayland compositor.</li>
        <li><strong>Waybar</strong>: For the customizable status bar.</li>
        <li><strong>Wofi</strong>: The simple yet powerful launcher.</li>
        <li><strong>The Linux Community</strong>: For the endless inspiration in building and theming.</li>
    </ul>

    <p>Enjoy your new Hyprland setup! ✨ Feel free to reach out if you have any questions or run into any issues!</p>


