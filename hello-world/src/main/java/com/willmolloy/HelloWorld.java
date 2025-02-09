package com.willmolloy;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Example main src.
 *
 * @author <a href=https://willmolloy.com>Will Molloy</a>
 */
public class HelloWorld {

  private final Logger log = LogManager.getLogger();

  public String hello(String text) {
    log.debug("Hello {}!", text);
    return "Hello %s!".formatted(text);
  }
}
