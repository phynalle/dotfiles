# 기본적인 개발환경 요구사항
- Editor - [helix](https://helix-editor.com/)
- VCS - git, [jj (jujutsu)](https://github.com/martinvonz/jj)
- Shell: [fish](https://fishshell.com/) (Unix-like), [nushell](https://www.nushell.sh/) (Windows)
- Multiplexer - [zellij](https://zellij.dev/) (Unix-like), [WezTerm](https://wezfurlong.org/wezterm/) (Windows)
- Font - [Cascadia Code](https://github.com/microsoft/cascadia-code) (PL 지원)

## 비고
### Zellij
multiplxer는 기본적으로 tmux를 선호하지만 Windows 지원을 하지 않아 아쉬운 점이 있다.
다른 프로그램들도 마찬가지긴 하지만 zellij는 Windows를 지원하려는 움직임이 있어서 채택.
사용성도 나쁘지 않다

### WezTerm
WezTerm은 터미널이지만 multiplexer로 활용가능해서 사용가능. zellij가 Windows를 지원하게 되면 교체할 예정
