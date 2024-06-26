# storeapp

Proyecto de una aplicación tipo store de flutter.

## Diagrama y flujo descriptivo

El App Está compuesto principalemente de 6 pantallas así:

- HomeScreen
- SearchScren
- CategoriesScreen
- DetailScreen
- CartScreen
- HelpScreen

![Diagrama](./documentation/appDiagram.png)

Cuando se corre la aplicación se revisa si tiene guardado un usuario en el Sharepreferences, y si no se encuentra creado un usuario se pide crear el usuario y se almacena localmente este usuario (No se hace una revisión contra el backend, ni se guarda una copia del backend de este usuario). De ahí se llega al Lobby en el HomeScreen.

Localmente en el sharepreferences también se guarda el carrito de compras el cual se crea, guardando un listado de Id de productos y las cantidades de estos. No se envía al backend nada del carrito y este se mantiene localmente cuando se agregan o eliminan productos.

### HomeScreen

Cuando inicia el app entra al HomeScren, la cual muestra un Splash cuando el app Inicia, y ahí se mira si se tiene un usuario registrado, si el usuario no está registrado se le pregunta al usuario los datos de registro, y ya cuando los datos están completos se muestra el lobby del HomeScreen.

![Splash](./documentation/splashScreen.jpg "Splash")

![Register](./documentation/registerForm.jpg "Register Form")

![Lobby](./documentation/lobby.jpg "Lobby")

Desde el HomeScreen se puede navegar a las otras pantallas así:

Desde la barra de Servicios: (La barra de servicios se podrá expandir con mas items)

- CategoryScreen
- SearchScreen
- HelpScreen

Al cartScreen, directamente haciendo tap en el ícono del carrito.

Al detailScreen haciendo tap en cualquier promoción de un producto, las cuales están divididas en 2 areas principales así:

- Promociones normales
- Promociones grandes

### CategoryScreen

La Pantalla de categorías tiene 2 areas principales, el área de las categorías y el área del listado de productos.

![CategoryScreen](./documentation/categoryScreen.jpg "CategoryScreen")

En las categorías se podrá escoger o todas con "All" o la categoría requerida.

El listado de productos va a mostrar todos los productos pertenecientes a la  categoría actual. Siempre va a inciar con la categoría "All". Desde el listado de productos se puede seleccionar el detalle del producto haciendo Tap sobre éste.

Desde esta pantalla también se puede entrar al carrito.

### DetailScreen

Esta es la pantalla encargada de mostrar el detalle del producto y pueda agregar productos al carrito.

![DetailScreen](./documentation/detailScreen.jpg "DetailScreen")

Desde esta pantalla también se puede entrar al carrito.

### SearchScreen

Esta pantalla tiene un área donde se escribe algún término o palabra que se quiera buscar de los productos, y va a mostrar un listado de los productos asociados al término buscado.

![SearchScreen](./documentation/searchScreen.jpg)

### CartScreen

Desde cualquier pantalla se puede acceder al CartScreen haciendo click sobre el ícono del carrito, el cual siempre va a mostrar cuantos items están en el carrito.

![CartScreen](./documentation/cartScreen.jpg)

En el cartScreen se ven cuantos items están agregados al carrito y se podrá modificar las cantidades de los productos agregados al carrito.

También se observa cuanto vale la suma de todos los productos.

### HelpScreen

![HelpScreen](./documentation/helpScreen.jpg)

Esta pantalla solo tiene información para ayuda y contacto, la cual es parametrizable.
