[![Codacy Badge](https://app.codacy.com/project/badge/Grade/14d830a1fc9844b08a8af90d65f1406e)](https://www.codacy.com/gh/PyFunceble-Templates/pyfunceble-miniconda?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=PyFunceble-Templates/pyfunceble-miniconda&amp;utm_campaign=Badge_Grade)
[![Build Status](https://travis-ci.com/dns-test/porn.host.rpz.svg?branch=master)](https://travis-ci.com/dns-test/porn.host.rpz)

## porn.host.srv
This zone is served by [SpamHausTech.com][1], but as it contains tremendous
numbers of [false-positives][2], we have decided to setup of an PyFunceble
test environment to prove why it is important to maintain a zone file

A first up eye-catcher is the usage of `*.userName.tumblr.com`
as there are no such thing on thumblr....

Another example is `britneyspears.ac` which does **NOT** contain any
adult(Pornographic) material at all

As we can read from our [powerDNS recursor](https://www.powerdns.com/recursor.html)'s
log, this is a incredible big zone

```
pdns_recursor: Loaded & indexed 4406096 policy records so far for RPZ zone 'porn.host.srv'
```

To see the number of FP's you should keep a eye on this file
<https://github.com/dns-test/porn.host.rpz/blob/master/dev-tools/output/logs/percentage/percentage.txt>

### DNS zones
If you are so lucky that you have updated your system to use a DNS resolver
rather than abusing your disk-IO with the `hosts` file, we generate a
zone regular RPZ supported DNS resolvers.

*Note*: If you'll read more about why you should switch to a local DNS resolver,
Please read this [Performance Test of Hosts File vs. Dns-recursors][3]

### RPZ
You'll find the RPZ formatted files at [My Privacy DNS](https://www.mypdns.org/w/rpz/)

The syntax used for is to provide a `NXDOMAIN` response

Ex.

```python
youseeporn.com		CNAME	.
*.youseeporn.com	CNAME	.
```

Any helpful [contributions](CONTRIBUTING.md) are appreciated

[1]: <https://docs.spamhaustech.com/dns-firewall/docs/source/zones/050-service-feeds.html#porn> "A huge False Positive zone from spamhaustech"
[2]: <https://www.mypdns.org/w/falsepositive/> "What is false-positives?"
[3]: <https://www.mypdns.org/w/performance_test_of_hosts_file_vs_dns-recursors/> "The best DNS firewall for privacy"
