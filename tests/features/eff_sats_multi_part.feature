Feature: Multipart-Key Effectivity Satellites

  @fixture.eff_satellite_multipart
  Scenario: [BASE-LOAD-MULTI] Load data into an non-existent effectivity satellite.
    Given the LINK link is empty
    And the EFF_SAT table does not exist
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 1000        | AAA      | GBR       | ONLINE      | DATAVAULT       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | 2000        | BBB      | SPA       | RETAIL      | BUSSTHINK       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | 3000        | CCC      | GBR       | ONLINE      | DATAVAULT       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [BASE-LOAD-MULTI] Load data into an empty effectivity satellite.
    Given the LINK link is empty
    And the EFF_SAT eff_sat is empty
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 1000        | AAA      | GBR       | ONLINE      | DATAVAULT       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | 2000        | BBB      | SPA       | RETAIL      | BUSSTHINK       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | 3000        | CCC      | GBR       | ONLINE      | DATAVAULT       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [INCREMENTAL-LOAD-MULTI] No Effectivity Change when duplicates are loaded
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 1000        | AAA      | GBR       | ONLINE      | DATAVAULT       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | 2000        | BBB      | SPA       | RETAIL      | BUSSTHINK       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | 3000        | CCC      | GBR       | ONLINE      | DATAVAULT       | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [INCREMENTAL-LOAD-MULTI] New Link record Added
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 4000        | DDD      | GER       | RETAIL      | BUSSTHINK       | 2020-01-10 | 9999-12-31 | 2020-01-10     | 2020-01-11 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('4000\|\|DDD\|\|GER\|\|RETAIL\|\|BUSSTHINK') | 2020-01-10 | 9999-12-31 | 2020-01-10     | 2020-01-11 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [INCREMENTAL-LOAD-MULTI] Link is Changed
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 4000        | CCC      | GBR       | ONLINE      | DATAVAULT       | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 2020-01-11 | 2020-01-11     | 2020-01-12 | orders |
      | md5('4000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [INCREMENTAL-LOAD-MULTI] 2 loads, Link is Changed Back Again
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('4000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('4000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-12 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 2020-01-11 | 2020-01-11     | 2020-01-12 | orders |
      | md5('4000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 5000        | CCC      | GBR       | ONLINE      | DATAVAULT       | 2020-01-12 | 9999-12-31 | 2020-01-12     | 2020-01-13 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 2020-01-11 | 2020-01-11     | 2020-01-12 | orders |
      | md5('4000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
      | md5('4000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-11 | 2020-01-12 | 2020-01-12     | 2020-01-13 | orders |
      | md5('5000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-12 | 9999-12-31 | 2020-01-12     | 2020-01-13 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [NULL-DFK-MULTI] No New Eff Sat Added if Driving Foreign Key is NULL and Latest EFF Sat Remain Open.
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 3000        | <null>   | GBR       | ONLINE      | DATAVAULT       | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [NULL-DFK-MULTI] No New Eff Sat Added if Driving Foreign Key is NULL and Latest EFF Sat is already closed
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 2020-01-11 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 3000        | <null>   | GBR       | ONLINE      | DATAVAULT       | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 2020-01-11 | 2020-01-09     | 2020-01-10 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [NULL-SFK-MULTI] No New Eff Sat Added if Secondary Foreign Key is NULL and Latest EFF Sat with Common DFK is Closed.
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | <null>      | DDD      | GBR       | ONLINE      | DATAVAULT       | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |

  @fixture.eff_satellite_multipart
  Scenario: [NULL-DFK-SFK-MULTI] No New Eff Sat Added if DFK and SFK are both NULL
    Given the LINK link is already populated with data
      | CUSTOMER_ORDER_PK                                | CUSTOMER_PK | ORDER_PK   | NATION_PK  | PLATFORM_PK   | ORGANISATION_PK  | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('1000') | md5('AAA') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | md5('2000') | md5('BBB') | md5('SPA') | md5('RETAIL') | md5('BUSSTHINK') | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | md5('3000') | md5('CCC') | md5('GBR') | md5('ONLINE') | md5('DATAVAULT') | 2020-01-10 | orders |
    And the EFF_SAT eff_sat is already populated with data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | NATION_ID | PLATFORM_ID | ORGANISATION_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | <null>      | <null>   | GBR       | <null>      | DATAVAULT       | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And I hash the stage
    When I load the LINK link
    And I load the EFF_SAT eff_sat
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK                                | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB\|\|SPA\|\|RETAIL\|\|BUSSTHINK') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC\|\|GBR\|\|ONLINE\|\|DATAVAULT') | 2020-01-09 | 9999-12-31 | 2020-01-09     | 2020-01-10 | orders |