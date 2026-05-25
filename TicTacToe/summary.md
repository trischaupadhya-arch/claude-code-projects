# Tic-Tac-Toe — Project Summary

## What it is
A two-player browser Tic-Tac-Toe game. Single file: `index.html` with all HTML, CSS, and JS inline. No build tools, no dependencies. Open directly in a browser or serve with `ruby serve.rb` (port 3456).

---

## Architecture

**All game state lives in 5 JS globals:**
- `board` — 9-element array (`null | 'X' | 'O'`), indices 0–8, left-to-right top-to-bottom
- `currentPlayer` — `'X'` or `'O'`
- `gameOver`, `aiMode`, `aiThinking` — booleans

**Every move goes through `placeMove(index, player)`**, which:
1. Writes to `board`, renders the cell
2. Calls `checkWin(player)` immediately — winner declared right away
3. If no winner and board not full, flips `currentPlayer` and updates status
4. If `aiMode` and it's now O's turn, sets `aiThinking = true`, waits 380ms, then calls `getBestMove()` → `placeMove()`

**AI is minimax with no depth limit** — plays perfectly (best possible outcome is a draw for the human). `checkWinOnBoard(b, player)` takes a board array parameter so minimax can evaluate hypothetical states without touching the real `board`.

**Victory overlay** (`#overlay`) shown/hidden via `.hidden` class. Trophy re-animation on replay uses `void trophyEl.offsetWidth` DOM reflow trick before reassigning the animation class.

---

## Key decisions made
- **Immediate win detection** — user originally requested "check after full rotation" (both players place before checking), but later changed to standard immediate detection
- **Minimax AI** — perfect play; O always blocks and takes wins; human can at best draw
- **Mode toggle** — pill selector at top: "2 Players" vs "vs AI"; switching resets the board
- **Status text** is context-aware: "Your turn (X)" / "AI is thinking…" in AI mode; "Player X/O's turn" in 2-player mode
- **AI win overlay** says "AI Wins!" instead of "Player O Wins!" when in AI mode

---

## Current state
Fully playable. Both modes work. Win highlighting (gold pulsing cells), trophy celebration with bounce+spin animation, draw detection, and "Play Again" / "New Game" buttons all functional.

---

## What's left to do
Nothing was explicitly scoped. Potential additions the user hasn't asked for yet:
- Difficulty selector for the AI (easy/medium/hard via depth-limited minimax)
- Score tracking across multiple games
- Animated X/O placement (scale-in on render)
- First-move randomization so AI mode doesn't always start the same way
