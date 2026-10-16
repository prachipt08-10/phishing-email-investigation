# Incident Report: Fake Casino "Free Gift" Email

| Field | Detail |
|---|---|
| Analyst | Prachi Thakare |
| Date analyzed | 2026-10-16 |
| Sample | sample-10000.eml (phishing_pot public dataset) |
| Verdict | **Phishing / malicious spam lure, high confidence** |
| MITRE ATT&CK | T1566.002 Phishing: Spearphishing Link |

## 1. Summary
The email uses the sender name "Casino Rewards" and the subject "Surprise! Check Your Account for a Free Gift". It tries to attract the reader with a free prize and sends them to links on woondsplay[.]com, a domain that several security vendors flag as phishing or malicious.

## 2. Evidence

### 2.1 Email header
- From name: "Casino Rewards"
- From address: finley.walker@ghjgamerisons03[.]onmicrosoft[.]com (a Microsoft free-tenant domain, not a casino domain)
- Return-Path: same as From
- SPF: **fail**, DKIM: pass, DMARC: none
- Note: DKIM pass only shows the message matches the sender's own domain, so it does not prove the sender is a real casino.

### 2.2 Message body
- The letter starts with long blocks of random characters. This looks like filler text meant to make each copy look different to spam filters.
- Links: several buttons point to woondsplay[.]com with long random tracking codes. The first link uses http, not https.
- Images are loaded from imgprom[.]com and imgur[.]com (names such as "CrazyTower" suggest a casino game banner, but the images were not viewed).
- No attachments.

### 2.3 Domain check
- woondsplay[.]com on VirusTotal: **8/92** vendors flag it as malicious
  - Phishing: alphaMountain.ai, Fortinet
  - Malicious: Bkav, CRDF, Lionic, Seclookup, SOCRadar, Webroot
  - Suspicious: ESET. Spam: Forcepoint ThreatSeeker
- Domain created about 1 year before analysis. Last analysis 3 days before.
- Limitation: 8 out of 92 is not a majority, but the vendors agree on the direction, and it matches the header findings.

## 3. Indicators of Compromise (IOCs)
| Type | Value |
|---|---|
| Domain | woondsplay[.]com |
| Domain | ghjgamerisons03[.]onmicrosoft[.]com |
| Email | finley.walker@ghjgamerisons03[.]onmicrosoft[.]com |
| URL | hxxp://woondsplay[.]com/rd/5piqTA... |
| Image host | imgprom[.]com (low value alone) |

## 4. Verdict
**Phishing / malicious spam lure, high confidence.** The header (SPF fail, sender mismatch) and the link domain reputation (8/92) point to the same conclusion. The final landing page was not opened.

## 5. Recommended actions
1. Block woondsplay[.]com and the sender domain at the mail gateway and web proxy.
2. Search mailboxes for the same subject or sender and delete matches.
3. If any user clicked: check browser history, reset passwords if any were entered, and review account activity.
4. Remind users that free-prize emails are lures and should be reported, not opened.
5. Follow-up: view the landing page safely in an isolated sandbox (not done here).
