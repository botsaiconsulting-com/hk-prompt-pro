# Piece pricing: technical specification

| Field | Value |
|---|---|
| Document ID | SPEC-2026-03 |
| Implemented at | `src/api/HK.Supreme.Api/Services/PricingService.cs` |
| Tests | `src/api/HK.Supreme.Api.Tests/PricingServiceTests.cs` |
| Status | Approved |

## 4. Business logic

| # | Condition | Outcome |
|---|---|---|
| P1 | Always | Metal value = net metal weight (g) x metal rate per gram |
| P2 | Always | Making charge = net metal weight (g) x making charge per gram |
| P3 | Stones present | Stone value = sum of carats x rate per carat for each stone line |
| P4 | Always | GST = 3% of (metal value + making charge + stone value) |
| P5 | Always | Total is rounded once, at the end, to the nearest rupee; a half rupee rounds up |
| P6 | Net metal weight is zero or less | The quote is refused |
