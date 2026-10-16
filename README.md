# Phishing Email Investigation (SOC Analyst Project)

I investigated 5 real phishing and spam emails from the public [phishing_pot](https://github.com/rf-peixoto/phishing_pot) dataset, the way a SOC analyst would: read the header, trace the path, check links and domains, decide a verdict, and write an incident report.

All work was done inside an isolated Kali Linux VM. Emails were only read as text. No link or attachment was opened.

## Results

| Sample | Type | Verdict | Confidence |
|---|---|---|---|
| sample-5 | Fake Chase "account blocked" | Phishing (credential harvesting) | High |
| sample-119 | Fake FBI "beneficiary fund" | Advance-fee fraud | High |
| sample-25 | Spoofed sender, "Pending Package" lure | Phishing / spam lure | Medium-high |
| sample-10000 | Fake casino "free gift" | Phishing / malicious spam lure | High |
| sample-10002 | Fake casino "money is waiting" | Phishing / malicious spam lure | High |

Key finding: sample-10000 and sample-10002 use different sender addresses but the same link domain, so they come from one campaign.

## Method

1. Header analysis: From, Reply-To, Return-Path, SPF, DKIM, DMARC, Received chain
2. Link extraction (decoded, not clicked)
3. Domain reputation check on VirusTotal
4. Message review using the S-L-U-G checklist: Sender, Links, Urgency, Greeting
5. Verdict, IOCs and recommended actions in an incident report

## What I learned

- SPF, DKIM and DMARC passing does not make an email safe (sample-5 passed everything and was still phishing).
- A clean scan today does not prove a link was clean at the time. Links can expire or hide behind a CAPTCHA.
- Not every bad email has a link or attachment (sample-119 only asks you to reply).
- An unrated domain is weak evidence, so the verdict has to be backed by other clues.
- Shared indicators (like one link domain) can connect separate emails into one campaign.

## Files

- `analyze.sh`: small helper script that prints header stamps, subject, links, attachments and the first part of the message
- `reports/`: one incident report per sample (summary, evidence, IOCs, verdict, recommended actions)

## Tools

Kali Linux, Bash, Python 3 (email library), grep/sed, VirusTotal

## Limitations

Landing pages were not opened, and images and short links were not expanded in a sandbox. Verdicts are based on headers, message content and domain reputation. All indicators are written in defanged form.

## Author

Prachi Thakare
