def with_scope(locator)
  locator ? within(locator) { yield } : yield
end