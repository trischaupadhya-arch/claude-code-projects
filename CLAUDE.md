# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Running the game

Open `index.html` directly in a browser — no build step or server required.

To serve it locally (useful for preview tooling):

```bash
ruby serve.rb   # serves on http://localhost:3456
```

## Architecture

The entire game is a single file: `index.html` with inline `<style>` and `<script>` blocks. There are no external dependencies, no build tools, and no separate CSS/JS files.

**Game state (JS globals):**
- `board` — 9-element array (`null | 'X' | 'O'`), indices 0–8 map to cells left-to-right, top-to-bottom
- `currentPlayer` — `'X'` or `'O'`
- `gameOver`, `aiMode`, `aiThinking` — boolean flags

**Core flow:**
- All moves go through `placeMove(index, player)`, which renders the cell, checks for a win immediately, then either ends the game or advances the turn
- Win detection (`checkWinOnBoard`) is checked after every single placement — there is no deferred/rotation rule
- In AI mode, after X places, `placeMove` schedules `getBestMove()` → `placeMove('O')` via `setTimeout(380ms)`

**AI:** Minimax with no depth limit — plays perfectly. `checkWinOnBoard(b, player)` accepts a board array parameter so minimax can work on hypothetical states without mutating the real `board`.

**UI state:** The victory overlay (`#overlay`) is shown/hidden via `.hidden` class. Trophy animation re-triggers on each game by forcing a DOM reflow (`void trophyEl.offsetWidth`) before reassigning the animation class.
