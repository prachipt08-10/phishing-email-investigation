# Incident Report: Fake FBI "Beneficiary Fund" Email (Advance-Fee Scam)

| Field | Detail |
|---|---|
| Analyst | Prachi Thakare |
| Date analyzed | 2026-10-16 |
| Sample | sample-119.eml (phishing_pot public dataset) |
| Verdict | **Advance-fee fraud (social engineering), high confidence** |

## 1. Summary
The email pretends to come from the FBI and says the reader is owed a fund of about 3.2 million USD. It asks how the reader wants to receive payment. The goal is to start a conversation and later collect personal details and "release fees".

## 2. Evidence
- From: "CHRISTOPHER A. WRAY" at vtc-sh[.]com[.]cn (a Chinese domain, not fbi.gov)
- Reply-To: fbiagent01@mail[.]ee (different from From)
- SPF: none, DKIM: none, DMARC: none (no authentication)
- Greeting: "Dear Beneficiary" (generic)
- Claims to be from the FBI, Interpol, the UN and the US President at once
- Leftover HTML tag in the text (copy-pasted template)
- Links: none. Attachments: none.

## 3. Indicators of Compromise (IOCs)
| Type | Value |
|---|---|
| Domain | vtc-sh[.]com[.]cn |
| Domain | mail[.]ee |
| Email | fbiagent01@mail[.]ee |
| Email | sha-mail1@vtc-sh[.]com[.]cn |

## 4. Verdict
**Advance-fee fraud, high confidence.** There is no link to scan, so the verdict rests on the sender mismatch, missing authentication and the content.

## 5. Recommended actions
1. Block the sender domain and the Reply-To address at the mail gateway.
2. Search mailboxes for the same subject and delete matches.
3. If a user replied: tell them to stop contact, never send money or ID documents, and report to the cyber crime portal.
4. Remind users: no government agency pays out funds through random emails.
