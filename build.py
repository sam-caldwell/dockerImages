#!/usr/bin/env python3
"""
    Build.py - A unified container builder using templates.
"""
from argparse import ArgumentParser

DEFAULT_OS = "ubuntu"
DEFAULT_OS_VER = "20.04"


def get_args():
    """
        Get commandline args

        :return: arguments (parsed)
    """
    parser = ArgumentParser()
    parser.add_argument(
        "--os",
        type=str,
        required=False,
        default=DEFAULT_OS,
        help="OS Type (e.g. Ubuntu)"
    )
    parser.add_argument(
        "--os_version",
        type=str,
        required=False,
        default=DEFAULT_OS_VER,
        help="OS Version"
    )
    parser.add_argument(
        "--language",
        type=str,
        required=True,
        default=None,
        help="Specify a language (e.g. java, python, node)"
    )
    parser.add_argument(
        "--language_version",
        type=str,
        required=True,
        default=None,
        help="Specify the language version (e.g. 3.9.1)."
    )
    parser.add_argument(
        "--repo",
        type=str,
        required=True,
        default=None,
        help="Specify the docker repository."
    )
    return parser.parse_args()


def main():
    """

    :return:
    """
    args=get_args()
    build_docker_image(compile_docker_file(args))


if __name__ == "__main__":
    main()
