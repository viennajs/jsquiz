# A weird number is defined as a number, n, such that the sum of all its divisors (excluding n itself) is greater than n, but no subset of its divisors sums up to exactly n.
window.WeirdNumbers = class WeirdNumbers
  this.find = (limit) ->
    (new WeirdNumbers()).find(limit)

  find: (limit) ->
    weird_numbers = []

    for number in [1..limit]
      divisors = this.divisors(number)

      if this.is_abundant(number, divisors) && this.not_semiperfect(number, divisors)
        weird_numbers.push(number)

    return weird_numbers

  # A number n is abundant if σ(n)>2n
  #
  # (or, in other words, if the sum of its divisors excluding n are bigger than n)
  is_abundant: (number, divisors) ->
    return this.abundance(number, divisors) > 0

  abundance: (number, divisors) ->
    _.inject(divisors, (acc,d) -> acc + d ) - 2*number


  # Semiperfect numbers are equal to the sum of all or some of its divisors
  not_semiperfect: (number, divisors) ->
    abundance = this.abundance(number, divisors)
    return false if _.include(divisors, abundance)

    # Now see if any combination sums of divisors yields the abundance.
    # We reject any divisors greater than the abundance and reverse the
    # result to try and get sums close to the abundance sooner.
    to_search = _.reject(divisors, (i) -> i > abundance)
    sum = _.inject(to_search, (a,b) -> a+b)

    return false if sum == abundance
    return true if sum < abundance
    return !this.sum_in_subset(abundance, to_search)

  sum_in_subset: (abundance, to_search) ->
    return false if abundance < 0
    return true if _.include(to_search, abundance)
    return false if to_search.length == 1

    f = to_search[0]
    remaining = to_search[1..-1]
    this.sum_in_subset((abundance - f), remaining) || this.sum_in_subset(abundance, remaining)

  # Calculates all the divisors of `number`
  divisors: (number) ->
    if (number < 1)
      throw "Argument error"

    small = []
    large = []
    end = Math.floor(Math.sqrt(number))

    for i in [1..end]
      if (number % i == 0)
        small.push(i)
        large.push(number / i) if i * i != number  # Don't include a square root twice

    large.reverse()

    return small.concat(large);
