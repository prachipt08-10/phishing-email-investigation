# Phishing Incident Report: Fake Chase "Account Blocked" Email

| Field | Detail |
|---|---|
| Analyst | Prachi Thakare |
| Date analyzed | 2026-10-16 |
| Sample | sample-5.eml (phishing_pot public dataset) |
| Email date | 19 Sep 2023 |
| Verdict | **Phishing (credential harvesting), high confidence** |
| MITRE ATT&CK | T1566.002 Phishing: Spearphishing Link |

## 1. Summary
The email pretends to be Chase bank and says the reader's account is blocked due to "unusual activities". It tells the reader to click "Reactivate Your Account" to verify. The sender, the link and the message style do not match a real bank, so the email is a phishing attempt to steal login details.

## 2. Evidence

### 2.1 Email header
- Subject: "Your Bank Account has been blocked due to unusual activities CASE# T53-H32-C10-C83"
- SPF: pass, DKIM: pass, DMARC: pass (policy p=none)
- The message came from a real Hotmail/Outlook account and was forwarded through Gmail.
- All IPs in the Received chain belong to Microsoft and Google, so the sender's real IP cannot be found from the headers.
- Note: passing authentication only proves the sender is real, not that the content is safe.

### 2.2 Message body
| # | Red flag |
|---|---|
| 1 | Claims to be Chase, but a second sender address from an unrelated domain (boonsupply[.]com) appears beside it |
| 2 | Generic greeting: "Dear Customer" |
| 3 | Fear and urgency: account blocked, "unusual activities" |
| 4 | Fake case number to look official |
| 5 | The button goes to dsgo[.]to, not to chase.com |
| 6 | Image loaded from a bulk-email service (createsend1[.]com) |
| 7 | Template placeholder left in the text: MC_PREVIEW_TEXT (placeholder) |

### 2.3 Link analysis
- Button link: hxxps://dsgo[.]to/CQECQEC... (long random ID)
- VirusTotal (scanned 2026-10-15): 0/93 detections
- The link redirects to a Google reCAPTCHA page (hxxps://www[.]google[.]com/recaptcha/api2/bframe). The final page body was empty.
- First seen on VirusTotal: 2023-09-19 (same day as the email).
- Limitation: a CAPTCHA can hide a page from automated scanners, and the link may be expired today, so the clean score is not proof of safety.

## 3. Indicators of Compromise (IOCs)
| Type | Value |
|---|---|
| Domain | dsgo[.]to |
| Domain | boonsupply[.]com |
| Domain | createsend1[.]com (bulk-mail tracking, low value alone) |
| URL | hxxps://dsgo[.]to/CQECQEC... |

## 4. Verdict
**Phishing, high confidence.** The verdict is based on the sender mismatch, the fear message and the non-Chase link. The final landing page could not be confirmed.

## 5. Recommended actions
1. Block dsgo[.]to and boonsupply[.]com at the mail gateway.
2. Search all mailboxes for the same subject or link and delete matches.
3. If any user clicked: reset their password, enable MFA and review their account activity.
4. Remind users: banks never ask you to verify through an email button.
5. Report the email to the real bank's phishing report address.
6. Follow-up: check boonsupply[.]com reputation (not done in this analysis).
