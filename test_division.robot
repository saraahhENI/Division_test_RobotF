*** Settings ***
Resource    test_divvision.resource

*** Test Cases ***
factoriser le test
    [Template]      Division simple
    # numerateur    diviseur        resultat
    5               2               2.50
    10              2               5.00
    5               3               1.67

factoriser cas euclidien
    Division euclidienne    10     3       3    1.00
    #Division euclidienne   10     3       3    2.00      --> fail, erreur d'arrondi de programme
    #Division euclidienne   400    150     2    100.00   # --> fail, erreur d'arrondi de programme

tableau cas eucledien
    [Template]          Division euclidienne
    # numerateur        diviseur        resultat        reste
    300                 4               75              0.00
    66                  5               13              1.00
    91                  5               18              1.00


tableau cas eucledien bugger
    [Template]          Division euclidienne
    [Tags]              Bug_Found
    # numerateur        diviseur        resultat        reste
    40                  7               5               5.00       #--> fail, erreur d'arrondi de programme
    15                  4               3               3.00       #--> fail, erreur d'arrondi de programme
    -32                 6               -5              2.00       #--> fail, erreur de négatif dans le programme


test nombre entier
     ${calcul}    Run Process    python       division.py       ${60}          ${15}
    Should Be Equal As Numbers   ${calcul.stdout}    4
    Should Be Empty    ${calcul.stderr}
    Should Be Equal    ${calcul.rc}    ${0}          msg= Le programme a planté
    
test division par zero
    ${calcul}    Run Process    python       division.py         12            ${0}
    Should Not Be Equal   ${calcul.rc}    ${0}

test nombre decimal
    ${calcul}    Run Process    python      division.py        --reste        ${12}         ${5}
    Should Be Equal    ${calcul.rc}         ${0}               msg= Le programme a planté
    Should Be Empty    ${calcul.stderr}
    Should Be Equal    ${calcul.stdout}     2\n2.00

test division avec un argument seulement
    [Tags]       negative test
    ${calcul}    Run Process    python       division.py         ${12}
    Should Not Be Equal    ${calcul.rc}      ${0}               msg= Le programme a planté
    Should Contain    ${calcul.stderr}       error
    
test division avec valeures négatives
    Division simple    -10    -5    2.00

division d'un nombre par une lettre
    Division en erreur       5       a                 rc_attendu=2    erreur_attendu= invalid float value
    Division en erreur       5       2      3          rc_attendu=2    erreur_attendu= unrecognized arguments: 3