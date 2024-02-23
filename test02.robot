*** Settings ***
Library                     OperatingSystem
Test Setup                  Log    début de test
Suite Setup                 Log    début suite
Suite Teardown              Log    Fin du test




*** Variables ***
${NOM_FICHIER}              test_fichier.txt
${TEXTE}                    Ceci est le contenu du fichier




# ceci est un commentaire
*** Test Cases ***
Test creation de fichier
    [Tags]                  feature-os  author-sarah
    [Documentation]         Ceci est la documentation de mon test
    [Setup]                 File Should Not Exist           ${NOM_FICHIER}
    [Teardown]              Mon teardown personnalisé
    #${texte}               Set Variable                    Ceci est le contenu du fichier
    #VAR                    ${texte}                        Ceci est le contenu du fichier
    Create File             ${NOM_FICHIER}                  ${TEXTE}
    File Should Exist       ${NOM_FICHIER}                  msg=Le fichier devrait être créé
    ${contenu}=             Get File                        ${NOM_FICHIER}
    Should Be Equal         ${contenu}                      ${TEXTE}
    # Remove File           test_fichier.txt


Test un test
    Log    pour voir si mes setup non personnalisé fonctionne



*** Keywords ***
Mon teardown personnalisé
    Remove File             ${NOM_FICHIER}
    Log                     Fichier nettoyé

