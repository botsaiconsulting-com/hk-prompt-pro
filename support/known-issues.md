# Gati known-issues library (training)

Fictional issues for training. One entry per issue. Steps are written so a user could follow them.

## KI-001 Report export to Excel stops part-way
- Symptoms: "Excel export only shows part of the data", "export cuts off", large reports missing rows at the bottom.
- Cause: the report is exported in the old .xls format, which holds at most 65,536 rows.
- Solution steps:
  1. In the report's export dialog, choose the .xlsx option instead of .xls.
  2. If .xlsx is not offered, run the report for a shorter date range, one quarter at a time.
- Who can do it: user.
- Last verified: 2026-09-12.

## KI-002 Bag movement screen shows the old metal weight after saving
- Symptoms: "weight still shows the old value after saving", "filing weight not updated on screen".
- Cause: the movement grid shows cached values until the screen is refreshed. The saved value is correct.
- Solution steps:
  1. Press F5 on the bag movement screen, or close and reopen it.
  2. Check the weight again. If it is still old, take a screenshot and send it to support with the bag number.
- Who can do it: user.
- Last verified: 2026-09-18.

## KI-003 Cannot log in on one computer after changing the password on another
- Symptoms: "login fails on the department PC", "password not accepted after I changed it".
- Cause: the desktop client on the other computer still has the old password saved.
- Solution steps:
  1. On the computer where login fails, open the client's login settings and clear the saved password.
  2. Log in with the new password.
  3. If the account is locked after several attempts, ask support to unlock it.
- Who can do it: user; unlocking is done by support.
- Last verified: 2026-08-30.

## KI-004 Delivery challan prints on the wrong printer
- Symptoms: "challan goes to the wrong printer", "printer resets every day".
- Cause: the client uses the default printer of the user profile, not of the computer.
- Solution steps:
  1. Open Print setup from the challan screen.
  2. Choose the printer and tick "Save as my default".
- Who can do it: user.
- Last verified: 2026-07-21.

## KI-005 A new style does not appear in style search
- Symptoms: "style not found", "new style missing in search".
- Cause: the style has been created but not yet approved in the style master.
- Solution steps:
  1. Support checks the style's approval status in the master.
  2. If it is pending, support asks the master data team to approve it.
- Who can do it: support.
- Last verified: 2026-09-02.

## KI-006 "Database timeout" while running reports at month-end
- Symptoms: "timeout error", "report hangs and fails" during the last days of the month.
- Cause: heavy month-end reports compete for the same database.
- Solution steps:
  1. Run the report for a narrower date range.
  2. Run large reports after 7 pm.
  3. If it fails outside month-end too, raise it to a developer with the report name and time.
- Who can do it: user; persistent cases go to a developer.
- Last verified: 2026-09-30.

## KI-007 Client style code not found when creating an order
- Symptoms: "client style not found", "client style code invalid" while creating an order.
- Cause: each company has its own database. The client style exists in another company's database.
- Solution steps:
  1. Check which company is selected at the top of the order screen.
  2. If the client style belongs to another company, raise a master data request to create it in this company.
- Who can do it: support, with the master data team.
- Last verified: 2026-09-25.

## KI-008 Monthly sales report total differs from the invoice register
- Symptoms: "sales report does not match invoices", "report total is higher than billing".
- Cause: some hand-written reports use the production sales price instead of the actual selling price.
- Solution steps:
  1. Note the report name and the month.
  2. Raise it to a developer to check which price column the report uses.
- Who can do it: developer.
- Last verified: 2026-09-29.
