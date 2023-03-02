#!/bin/sh

# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    # sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.entangled/config/config.toml
    sed -i '' 's/seeds = ""/seeds = "ed0ce7e318257108ce148b5a5c4c36286df3ef89@192.168.1.5:26656"/g' $HOME/.entangled/config/config.toml
  else
    # sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.entangled/config/config.toml
    sed -i 's/seeds = ""/seeds = "ed0ce7e318257108ce148b5a5c4c36286df3ef89@192.168.1.5:26656"/g' $HOME/.entangled/config/config.toml
fi
