"""Package metadata smoke tests."""


def test_package_import_and_version() -> None:
    import biblegamecard

    assert biblegamecard.__version__ == "0.1.0"
