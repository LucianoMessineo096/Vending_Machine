<%-- 
    Document   : sideNavComponent
    Created on : 8 dic 2022, 19:11:17
    Author     : luciano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
        
      <jsp:include page="/View/styles/sideNavStyles.jsp"></jsp:include>  

  </head>
  <body>
        <nav class="main-menu">
            <ul>
                <li>
                    <a href='#' id="personalData">
                        <i class="fa fa-user fa-2x"></i>
                        <span class="nav-text">
                            Dati Personali
                        </span>
                    </a>
                  
                </li>
                <li class="has-subnav">
                    <a href='#' id="wallet">
                        <i class="fa fa-credit-card fa-2x"></i>
                        <span class="nav-text">
                            Wallet
                        </span>
                    </a>
                    
                </li>
                <li class="has-subnav">
                    <a href='#' id="purchase">
                       <i class="fa fa-shopping-cart fa-2x"></i>
                        <span class="nav-text">
                            Acquisto
                        </span>
                    </a>
                    
                </li>
                <li class="has-subnav">
                    <a  href='#' id="purchasesMade">
                       <i class="fa fa-money fa-2x"></i>
                        <span class="nav-text">
                            Acquisti Effettuati
                        </span>
                    </a>
                   
                </li>
                <li>
                    <a href='#' id="usersManagement">
                        <i class="fa fa-users fa-2x"></i>
                        <span class="nav-text">
                            Gestione Utenti
                        </span>
                    </a>
                </li>
                <li>
                    <a href='#' id="machinesManagement">
                        <i class="fa fa-list fa-2x"></i>
                        <span class="nav-text">
                           Gestione Macchinette
                        </span>
                    </a>
                </li>
                <li>
                   <a href='#' id="productsManagement">
                       <i class="fa fa-coffee fa-2x"></i>
                        <span class="nav-text">
                            Gestione Prodotti
                        </span>
                    </a>
                </li>
                
            </ul>

            <ul class="logout">
                <li>
                   <a href='/SmartVendingMachine/AutenticationManagement/logout'>
                       <i class="fa fa-power-off fa-2x"></i>
                       <span class="nav-text">
                           Logout
                       </span>
                    </a>
                </li>  
            </ul>
            
        </nav>
  </body>
</html>