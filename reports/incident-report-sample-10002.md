# Incident Report: Fake "MadCasino Rewards - Your Money Is Waiting" Email

| Field | Detail |
|---|---|
| Analyst | Prachi Thakare |
| Date analyzed | 2026-10-16 |
| Sample | sample-10002.eml (phishing_pot public dataset) |
| Verdict | **Phishing / malicious spam lure, high confidence** |
| MITRE ATT&CK | T1566.002 Phishing: Spearphishing Link |

## 1. Summary
The email uses the sender name "MadCasino rewards" and the subject "Check Your Mail - Your money is waiting!". It tempts the reader with money and sends them to links on woondsplay[.]com. It belongs to the same campaign as sample-10000 (same link domain, different sender).

## 2. Evidence

### 2.1 Email header
- From name: "MadCasino rewards" (encoded, with emojis)
- From address: scout.robinson@gbnfrostbornwarriors04[.]onmicrosoft[.]com (free Microsoft tenant, not a casino domain)
- Return-Path: same as From
- SPF: **fail**, DKIM: pass, DMARC: none

### 2.2 Message body
- The letter starts with long random character blocks (filler text).
- About 8 unique links, all to woondsplay[.]com over plain http, each with a different long tracking code. Each link appears twice in the source (HTML-encoded and decoded versions).
- One image hosted on imgur[.]com (not viewed).
- One broken link containing politico[.]com looks like leftover HTML from a template and is not treated as an indicator.
- No attachments.

### 2.3 Domain check
- woondsplay[.]com: 8/92 vendors flag it (Fortinet and alphaMountain.ai: phishing; Bkav, CRDF, Lionic, Seclookup, SOCRadar, Webroot: malicious). Checked during analysis of sample-10000.
- Campaign link: same link domain as sample-10000, but a different sender tenant.
- Limitation: the landing page was not opened, and 8/92 is not a majority.

## 3. Indicators of Compromise (IOCs)
| Type | Value |
|---|---|
| Domain | woondsplay[.]com |
| Domain | gbnfrostbornwarriors04[.]onmicrosoft[.]com |
| Email | scout.robinson@gbnfrostbornwarriors04[.]onmicrosoft[.]com |
| URL | hxxp://woondsplay[.]com/index.php?search=4... |

## 4. Verdict
**Phishing / malicious spam lure, high confidence.** SPF failed, the sender name does not match the address, and the links go to a domain flagged by several vendors and shared with another phishing sample.

## 5. Recommended actions
1. Block woondsplay[.]com at the mail gateway and web proxy. Also block the sender domain.
2. Hunt for woondsplay[.]com in proxy and DNS logs to find any user who clicked.
3. Search mailboxes for the same subject or sender and delete matches.
4. If any user clicked: check browser history, reset passwords if any were entered, and review account activity.
5. Consider blocking all external senders that use onmicrosoft[.]com addresses unless explicitly allowed.
6. Follow-up: view the landing page safely in an isolated sandbox (not done here).
