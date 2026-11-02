# tailwindcss-theme.nvim

Port a Neovim del tema **"tailwindcss-theme"** que tailwindcss.com usa en sus
bloques de codigo (resaltado con Shiki).

## Procedencia y licencia

- Tema origen: https://github.com/tailwindlabs/tailwindcss.com/blob/main/src/components/syntax-highlighter/theme.json
- Paleta: valores oklch de la paleta por defecto de Tailwind CSS v4
  (https://github.com/tailwindlabs/tailwindcss/blob/main/packages/tailwindcss/theme.css), convertidos a sRGB.
- El repo del sitio **no incluye archivo LICENSE** (es codigo del sitio,
  marcado private). Este port incluye atribucion a Tailwind Labs y se
  distribuye para uso personal; no hay terminos de redistribucion explicitos
  del tema original.

Solo variante **oscura**: la documentacion de Tailwind no define una variante
clara de este tema.

## Que es fiel y que es adaptado

**Fiel al original (1:1):** la paleta. Cada `var(--color-*)` del theme.json se
resolvio a su hex exacto de la paleta Tailwind v4 y los `color-mix()` se
calcularon sobre el fondo efectivo (#10131e = gray-950 con capa white/5, el
fondo real de los bloques de codigo de la web).

**Adaptado:** la clasificacion. El tema original usa scopes de TextMate
(`entity.name.function`, `source.css support.function`, ...) y Neovim usa
captures de Treesitter o grupos de sintaxis legacy. El mapeo se hizo siguiendo
las reglas del theme.json (incluidas sus reglas especificas para HTML, CSS,
JSON y JS/JSX) y se verifico cargando el colorscheme en Neovim 0.11.4 con
nvim-treesitter (parsers html/css/javascript): tags `#fb64b6`, atributos
`#cad5e2`, strings `#74d4ff`, propiedades CSS `#74d4ff`, selectores `#fb64b6`,
funciones `#96f7e4`, keywords `#c4b4ff`, variables `#ffa1ad`, numeros
`#fee685`, comentarios `#90a1b9` en italica.

Sin treesitter, se incluyen fallbacks para la sintaxis legacy de Vim
(html/xml/css/json/sh) con la misma paleta; la clasificacion es menos fina
(es lo que distingue, p. ej., `StorageClass` de una propiedad CSS).

Otras adaptaciones:
- Fondo: el tema original define `editor.background: transparent`. Por
  defecto se usa #10131e (el fondo efectivo de los bloques de la web);
  `transparent = true` hereda el de tu terminal.
- CursorLine: el `editor.lineHighlightBackground` original (slate-300 al 50%)
  quedaba demasiado agresivo; se uso #24323e, el fondo "highlighted-word" que
  la propia web aplica a palabras resaltadas.
- La seccion `colors` del theme.json (UI de VS Code) se mapeo a equivalentes
  de Neovim: statusline, floats, Pmenu, pestanas, diffs, diagnosticos, git y
  colores ANSI de terminal. La statusline se adapto a slate-800 (la del
  original, slate-300 clara, es un residuo de VS Code).
- Matices keyword/storage del original (`function` como storage slate-300 en
  JS) siguen las convenciones de captures de nvim-treesitter
  (`@keyword.function` violet-300).

## Instalacion

### Manual

    cp -r colors ~/.config/nvim/
    cp -r lua ~/.config/nvim/

Y en tu init.lua:

    vim.cmd.colorscheme("tailwindcss-theme")

### Con lazy.nvim (como plugin local)

    {
      dir = "~/ruta/a/tailwindcss-theme.nvim",
      name = "tailwindcss-theme",
      priority = 1000,
      config = function()
        require("tailwindcss-theme").setup({
          -- transparent = true,     -- editor.background es transparente en el tema original
          -- italic_comments = true, -- los comentarios van en italica en tailwindcss.com
        })
        vim.cmd.colorscheme("tailwindcss-theme")
      end,
    }

Requiere `termguicolors` (se activa solo al cargar). Recomendado:
nvim-treesitter para la fidelidad verificada arriba.

## Paleta (extraida)

| Uso | Variable Tailwind | Hex |
|---|---|---|
| Texto principal | slate-50 | #f8fafc |
| Comentarios, puntuacion | slate-400 | #90a1b9 |
| Keywords, soporte | violet-300 | #c4b4ff |
| Strings, valores de atributo | sky-300 | #74d4ff |
| Variables | rose-300 | #ffa1ad |
| Funciones | teal-200 | #96f7e4 |
| Tags, selectores CSS | pink-400 | #fb64b6 |
| Constantes, numeros, booleanos | amber-200 | #fee685 |
| Atributos, tipos, propiedades JS | slate-300 | #cad5e2 |
| Unidades CSS | teal-100 | #cbfbf1 |
| Funciones CSS (var(), rgba()) | blue-200 | #bedbff |
