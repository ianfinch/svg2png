# svg2png

Build a docker image which uses `cairosvg` to convert from `SVG` to `PNG`

## Usage

```docker run --rm -ti -v $PWD:/home/appuser --user $UID guzo/svg2png cairosvg image.svg -o image.png```
