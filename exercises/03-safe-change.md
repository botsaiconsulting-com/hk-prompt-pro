# 03 Safe change and tests (Theme 2, Part A)

Task: move the legacy order entry screen (`src/web/legacy/order-entry.html` and `order-entry.js`) to a React component, without changing what it calculates.

1. Switch to plan mode (Shift+Tab). Ask for a plan. Approve it only when it names every file it will touch.
2. Create a branch: `git switch -c <pair>/react-order-entry`.
3. `/hk test src/web/legacy/order-entry.js` before changing anything. Read what the tests pin. Did they find anything odd?
4. Make the change. Run `npm test` in `src/web`.
5. `/hk review <pair>/react-order-entry`. At the same time, the other pair and Pawan review the same diff by hand.
6. Compare: found by both, found only by Claude, found only by a person, noise.

Fast finishers: `/hk test sql/<your file>.sql` from card 02.

Human check: no file outside the plan changed, and the React component gives the same per-piece total as the legacy screen for the default inputs.
