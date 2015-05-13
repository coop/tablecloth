Feature: LOL

  Scenario: Transformations
    Given the world functions as expected
    When we have a list of transactions like:
      | Transaction ID | Amount |
      | 124            | $50    |
      | 456            | $100   |
    Then something magical should happen

  Scenario: Retaining Previous Values
    Given the world functions as expected
    When we have a list of orders like:
      | Order ID | Transaction ID | Amount |
      | 1        | 124            | $50    |
      |          | 456            | $100   |
      | 2        | 789            | $75    |
    Then something magical should happen
