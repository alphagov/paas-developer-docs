# Government PaaS Developer Docs

This project uses [MkDocs][]. It is automatically built and hosted by [Read
the Docs][] at the following URL:

- https://government-paas-developer-docs.readthedocs.io/en/latest/

[MkDocs]: http://www.mkdocs.org/
[Read the Docs]: https://readthedocs.org/

## Setup

You need the following things installed:
- pip
- libjpeg  (libjpeg-dev on ubuntu/Debian)

It is recommended that you use [virtualenv][] if you want to run the build
process locally.

[virtualenv]: https://virtualenv.pypa.io/en/latest/

    virtualenv env
    source ./env/bin/activate

To install the dependencies:

    pip install -Ur requirements.txt

## Preview

To preview your changes locally run:

    mkdocs serve

Then visit:

- http://127.0.0.1:8000

## Testing

The only test at the moment is for broken internal links.
You can test manually using

    ./check_links.sh

The script starts a mkdocs server of its own, and kills it afterwards.

The link checker will check whether internal links point to pages which actually exist.
It won't check anchors (https://github.com/wummel/linkchecker/issues/557) and won't do much more than check well-formedness for mailto links.
It won't currently check links to external sites, but we can enable that functionality if we wish to later on.

[Travis][] runs `./check_links.sh` on each commit.

[Travis]: https://travis-ci.org/alphagov/paas-developer-docs
