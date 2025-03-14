1. Double check ssh is fully removed, openssh, sshd. ```Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue -Include *ssh*,*openssh*,*sshd*,*ssh_server*,*ssh_client*```
2. block port 22
3. Double check WSL is removed
4. Check WIN-01, WIN-02, programs, services, exclusions, run defender scans
5. Check IIS on DC-01
6. 7zip open?
