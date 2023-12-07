% ---------------------------------------- %
% Created by lukasl-dev
% https://github.com/lukasl-dev/elegantex
% ---------------------------------------- %

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantex}[A fancy LaTeX template.]
\LoadClass[a4paper]{article}

% ---------------------------------------- %
% Packages
% ---------------------------------------- %

\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{tocloft}
\RequirePackage{fontspec}
\RequirePackage{float}

\usetikzlibrary{calc}

% ---------------------------------------- %
% Options
% ---------------------------------------- %

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

% ---------------------------------------- %
% Variables
% ---------------------------------------- %

\def\@subtitle{}
\def\@slogan{}
\def\@logo{}

\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\slogan}[1]{\def\@slogan{#1}}
\newcommand{\logo}[1]{\def\@logo{#1}}

% ---------------------------------------- %
% Preferences
% ---------------------------------------- %

% font family
\setmainfont{Inter}

% page margins
\geometry{top=3cm, bottom=2cm, left=2cm, right=2cm}

% max toc depth
\setcounter{tocdepth}{2}

% default color scheme
\definecolor{primary}{RGB}{91, 35, 99} 
\definecolor{darkprimary}{RGB}{61, 5, 69}
\definecolor{accentprimary}{RGB}{108, 41, 117}

\newcommand{\primary}[1]{\definecolor{primary}{RGB}{#1}}
\newcommand{\darkprimary}[1]{\definecolor{darkprimary}{RGB}{#1}}
\newcommand{\accentprimary}[1]{\definecolor{accentprimary}{RGB}{#1}}

% page style
\pagestyle{fancy}

% clear fancy preset
\fancyhf{}

% remove the header line
\renewcommand{\headrulewidth}{0pt}

% page numbering
\fancyfoot[C]{\thepage}

% solid header
\fancyhead[C]{
    \begin{tikzpicture}[remember picture,overlay]
        % Define the background rectangle area for clipping
        \path[clip] (current page.north west) rectangle ([yshift=-2cm]current page.north east);

        % Gradient shade for header background
        \shade[left color=primary, right color=darkprimary] (current page.north west) rectangle ([yshift=-2cm]current page.north east);

        % Check if slogan is set
        \ifx\@subtitle\@empty
            % If slogan is not set, render only the title vertically centered
            \node[anchor=center, text=white, font=\large] at ([yshift=-1cm]current page.north) {\textbf{\@title}};
        \else
            % If slogan is set, render both title and slogan
            \node[anchor=center, text=white, font=\large] at ([yshift=-0.75cm]current page.north) {\textbf{\@title}};
            \node[anchor=center, text=white, font=\large] at ([yshift=-1.3cm]current page.north) {\@subtitle};
        \fi
    \end{tikzpicture}
}

% link colours
\hypersetup{
    colorlinks=true,
    linkcolor=primary,
    urlcolor=primary,
    citecolor=primary,
}

% title page
\renewcommand{\maketitle}{
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]
            % Create a gradient background
            \shade[top color=primary, bottom color=darkprimary] (current page.south west) rectangle (current page.north east);

            % Add a circle orbit at the actual bottom-right corner
            \foreach \i in {18, 29, 34} {
                \draw[accentprimary, opacity=1] ([xshift=-\i cm, yshift=\i cm]current page.south east) circle (\i cm);
            }

            % Add title and logo
            \node at ([yshift=4cm]current page.center) {
                \color{white}
                \begin{minipage}{.8\textwidth}
                    \begin{figure}[H]
                        \centering
                        \ifx\@logo\empty
                        \else
                            \begin{figure}[H]
                                \centering
                                \includegraphics[width=0.5\textwidth]{\@logo}
                            \end{figure}
                            \vspace{0.2cm}
                        \fi
                    \end{figure}
                    \vspace{0.2cm}
                    \begin{center}
                        \fontsize{40}{48} \selectfont \textbf{\@title}
                        \\
                        \vspace{0.5cm}
                        \LARGE{\@subtitle}
                        \\
                        \vspace{2cm}
                        \Large{\@slogan}
                    \end{center}
                \end{minipage}
            };

            \node at ([yshift=3cm]current page.south) {
                \color{white}
                \begin{minipage}{\textwidth}
                    \centering
                    \Large{\@author}
                \end{minipage}
            };

        \end{tikzpicture}
        \thispagestyle{empty}
    \end{titlepage}
}
