#!/usr/bin/env python

from distutils.core import setup

setup(name='leo-cli',
    version='0.2',
    description='leo.org command line tool',
    author='Yves Fischer',
    author_email='yvesf+github@xapek.org',
    license="MIT",
    url='https://github.com/yvesf/leo-cli',
    scripts=['leo'],
    install_requires=['requests >= 1.0.0'],
    classifiers = [
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "Environment :: Console",
        "Operating System :: OS Independent",
        "License :: OSI Approved :: MIT License",
    ]
)
