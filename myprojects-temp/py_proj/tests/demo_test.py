#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2023 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.

"""

"""
import unittest
import yaml

# python >= 3.7
import importlib.resources as importlib_resources


class TestStringMethods(unittest.TestCase):
    def test_config(self):
        pkg = importlib_resources.files("demo")
        default_config_file = pkg / "resources" / "default_config.yaml"
        config_str = None
        with default_config_file.open() as fp:
            config_str = fp.read()
        self.assertIsNotNone(config_str)
        # config_str = default_config_file.open().read()
        config = yaml.load(config_str, Loader=yaml.SafeLoader)
        self.assertIsNotNone(config)

    def test_isupper(self):
        self.assertTrue("FOO".isupper())
        self.assertFalse("Foo".isupper())


if __name__ == "__main__":
    unittest.main()
