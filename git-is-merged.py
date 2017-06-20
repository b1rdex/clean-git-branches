# this is from https://github.com/larsks/github-tools/blob/master/git-is-merged

import sys
import github
import argparse
import subprocess

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('ref', nargs='?', default='HEAD')
    p.add_argument('--login_or_token', default=None)
    p.add_argument('--password', default=None)
    return p.parse_args()

def main():
    args = parse_args()

    login = None if args.login_or_token == '' else args.login_or_token
    password = None if args.password == '' else args.password

    ref = subprocess.check_output(['git', 'rev-parse', args.ref]).strip()
    G = github.Github(login, password)

    res = G.search_issues(ref)

    issue_states = [issue.state == 'closed' for issue in res]
    retval = 0
    if not issue_states:
        msg = 'There are no pull requests associated with {}'
        retval = 4
    elif all(issue_states):
        msg = 'All pull requests for {} are closed.'
        retval = 0
    elif any(issue_states):
        msg = 'Some pull requests for {} are closed.'
        retval = 1
    else:
        msg = 'All pull requests for {} are open.'
        retval = 2

    print (msg.format(ref))

    if issue_states:
        print ("Found results:")
        print ("\n".join([issue.html_url for issue in res]))

    sys.exit(retval)

if __name__ == '__main__':
    main()
