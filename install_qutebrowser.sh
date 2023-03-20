sudo apt install -y qutebrowser
git clone https://github.com/dracula/qutebrowser-dracula-theme.git ~/.config/qutebrowser/dracula

cat <<EOT >> ~/.config/qutebrowser/config.py
import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
EOT
