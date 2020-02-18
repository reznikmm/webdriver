WebDriver
=========

[![CircleCI](https://circleci.com/gh/reznikmm/webdriver.svg?style=svg)](https://circleci.com/gh/reznikmm/webdriver)
[![reuse compliant](https://img.shields.io/badge/reuse-compliant-green.svg)](https://reuse.software/)

> Ada binding to WebDriver API

[WebDriver](https://www.w3.org/TR/webdriver/)
is a remote control interface that enables introspection and
control of user agents. It provides a platform- and language-neutral wire
protocol as a way for out-of-process programs to remotely instruct the
behavior of web browsers.

This project is an Ada library to work WebDriver. Currently it's been
tested with [ChromeDriver](https://chromedriver.chromium.org/).


## Install

Run
```
make all install PREFIX=/path/to/install
```

### Dependencies
It depends on [Matreshka](https://forge.ada-ru.org/matreshka) library
and [AWS](https://github.com/AdaCore/aws).

Install ChromeDriver:
```
sudo apt install chromium-chromedriver
```

## Usage
Add `with "webdriver";` in your project file.

Run `chromedriver --verbose` then run your program or `.objs/ex/test` as
an example.

## Maintainer

[@MaximReznik](https://github.com/reznikmm).

## Contribute

Feel free to dive in!
[Open an issue](https://github.com/reznikmm/webdriver/issues/new) or submit PRs.

## License

[MIT](LICENSE) © Maxim Reznik


