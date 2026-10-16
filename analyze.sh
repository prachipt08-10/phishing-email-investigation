#!/bin/bash
f="$1"
echo "=== HEADER STAMPS ==="
sed '/^$/q' "$f" | grep -i -E "^(From|Reply-To|Return-Path|Received-SPF):"
grep -i -o -E "(spf|dkim|dmarc)=[a-z]+" "$f" | sort -u
echo
python3 - "$f" <<'PY'
import email, re, sys
from email import policy
m = email.message_from_file(open(sys.argv[1]), policy=policy.default)
print("=== SUBJECT ===")
print(m['subject'])
links = set()
for p in m.walk():
    if p.get_content_type() in ('text/plain', 'text/html'):
        links |= set(re.findall(r'https?://[^\s"<>\]]+', p.get_content()))
print("\n=== LINKS ===")
for u in sorted(links):
    print(" ", u)
print("\n=== ATTACHMENTS ===")
print(" ", [p.get_filename() for p in m.iter_attachments()] or "none")
print("\n=== LETTER (first 1200 characters) ===")
b = m.get_body(preferencelist=('plain', 'html'))
print(b.get_content()[:1200] if b else "no body")
PY
