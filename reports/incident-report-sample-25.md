# Incident Report: Spoofed Sender "iPhone 14 Pro / Pending Package" Email

| Field | Detail |
|---|---|
| Analyst | Prachi Thakare |
| Date analyzed | 2026-10-16 |
| Sample | sample-25.eml (phishing_pot public dataset) |
| Verdict | **Phishing / spam lure, medium-high confidence** |
| MITRE ATT&CK | T1566 Phishing (sub-technique not confirmed) |

## 1. Summary
The email shows a prize-style sender name ("iPhone 14 Pro") and a "Pending Package (1)" subject, both written with strikethrough characters. The From address uses the name of a real company (invoiceninja[.]com), but the real sending domain is different. The body contains LinkedIn job-digest content, which looks like filler.

## 2. Evidence

### 2.1 Email header
- From name: "iPhone 14 Pro" (strikethrough characters)
- From address: noreply@invoiceninja[.]com
- Return-Path: bounce@molestiasmxoql[.]co[.]uk (does not match From)
- SPF: none, DKIM: none, DMARC: fail
- Subject: "Pending Package (1)" (strikethrough characters)

### 2.2 Message body
- The letter is a copy of a LinkedIn "Top job picks" digest with LinkedIn links.
- The links in the text are LinkedIn, t.co and lnkd.in links (some cut short by email line breaks).
- The two images are loaded from iili[.]io. Their content was not viewed.
- No attachments.

### 2.3 Domain check
- molestiasmxoql[.]co[.]uk on VirusTotal: 0/92, mostly "Unrated", last analysis about 3 years ago
- Tagged "dga" (looks algorithm-generated)
- Limitation: an unrated domain with a clean score is weak evidence. The verdict rests mainly on the header mismatch and DMARC failure.

## 3. Indicators of Compromise (IOCs)
| Type | Value |
|---|---|
| Domain | molestiasmxoql[.]co[.]uk |
| Email | bounce@molestiasmxoql[.]co[.]uk |
| Spoofed sender | noreply@invoiceninja[.]com |
| Image host | iili[.]io (low value alone) |

## 4. Verdict
**Phishing / spam lure, medium-high confidence.** The sender is spoofed, DMARC failed, and the sending domain does not match the From address. The goal of the email was not confirmed because the images and short links were not opened.

## 5. Recommended actions
1. Block molestiasmxoql[.]co[.]uk at the mail gateway.
2. Enforce DMARC failure handling (quarantine or reject) for inbound mail.
3. Search mailboxes for the same subject or sender and delete matches.
4. Remind users to ignore prize and parcel emails and never open unknown image or short links.
5. Follow-up: safely view the images and expand the short links in an isolated sandbox (not done here).
