# -*- coding: utf-8 -*-

# Learn more: https://github.com/kennethreitz/setup.py

from setuptools import setup, find_packages


with open('README.rst') as f:
    readme = f.read()

with open('LICENSE') as f:
    license = f.read()

setup(
    name='extr_actions_jp',
    version='0.1.0',
    description='extract actions (verbs, gerunds, etc) from texts',
    long_description=readme,
    author='Masahiro Okamoto',
    author_email='motchyenator@gmail.com',
    url='https://github.com/mokamotosan/extr_actions_jp',
    license=license,
    packages=find_packages(exclude=('tests', 'docs'))
)

