# Test for for indexes to return correct values, e.g.
# tested against other software


test_that("PVAFF returns expected value", {
  v <- indexPvaff(boeker)
  expect_equal(v, 0.42007)
})


test_that("indexDilemma matches Gridcor results", {
  id <- indexDilemma(boeker, self = 1, ideal = 2, r.min = .35)
  expect_equal(id$no_ids, 4)
  
  #zero dilemmas do not cause error
  id <- indexDilemma(boeker, self = 1, ideal = 2, r.min = .99)
  expect_equal(id$no_ids, 0)
})


test_that("indexSelfConstruction works correctly", {
  
  # by default, other element are all except self and ideal
  x <- indexSelfConstruction(feixas2004, self = 1, ideal = 13)
  check <- length(x$other_elements) == ncol(feixas2004) - 2
  expect_true(check)
  
  # error is thrown if i is out of range
  expect_error({
    x <- indexSelfConstruction(feixas2004, 1, 14)
  })
  expect_error({
    x <- indexSelfConstruction(feixas2004, 0, 13)
  })
  expect_error({
    x <- indexSelfConstruction(feixas2004, 1, 13, others = 0)
  })
  # duplicate indexes not allowed
  expect_error({
    x <- indexSelfConstruction(feixas2004, 1, 13, others = c(3,3,4))
  })
  # rounding of 'others' element works correctly
  a <- indexSelfConstruction(feixas2004, self = 1, ideal = 13, round = FALSE)
  b <- indexSelfConstruction(feixas2004, self = 1, ideal = 13, round = TRUE)
  expect_true({
    all(round(ratings(a$grid)) == ratings(b$grid))
  })

})


test_that("indexDilemmatic works correctly", {
  
  # by default, other element are all except self and ideal
  x <- indexDilemmatic(feixas2004, ideal = 13)
  expect_true(x$n_dilemmatic == 1)
  
  # error is thrown if i is out of range
  expect_error({
    x <- indexDilemmatic(feixas2004, ideal = 14)
  })
  expect_error({
    x <- indexDilemmatic(feixas2004, ideal = 0)
  })
  
  # warn for even scale length
  expect_warning({
    x <- randomGrid(range = c(1, 6))
    indexDilemmatic(x, ideal = 1)
  })
  # warn for 0 deviation with long scale
  expect_warning({
    x <- randomGrid(range = c(0, 100))
    indexDilemmatic(x, ideal = 1)
  })
  
})


test_that("matches works correctly", {
  
  m <- matches(feixas2004)
  
  # error is thrown if i is out of range
  expect_error({
    m <- matches(feixas2004, deviation = -1)
  })
  expect_error({
    m <- matches(feixas2004, diag.na = NA)
  })
  
  expect_error({
    print(m, width = -1)
  })
  
  ## check results
  x <- feixas2004
  
  # maximal no of matches per C/E correct (infinity case gives max number)
  m <- matches(x, deviation = Inf, diag.na = FALSE)
  expect_true(all(m$elements == nrow(x)))
  expect_true(all(m$constructs == ncol(x)))
  
  # maximal possible number of matches is correct  
  m <- matches(x, deviation = Inf)
  expect_true(m$max_constructs == sum(m$constructs, na.rm = T) / 2)
  expect_true(m$max_elements == sum(m$elements, na.rm = T) / 2)

})


test_that("indexBieri works correctly", {
  
  x <- feixas2004
  b <- indexBieri(x)
  
  # error is thrown if i is out of range
  expect_error({
    b <- matches(x, deviation = -1)
  })
  
  ## check results
  # maximal no of matches per C correct (infinity case gives max number)
  b <- indexBieri(x, deviation = Inf)
  expect_true(all(na.omit(b$constructs) == ncol(x)))
})

