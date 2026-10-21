/**
 * BikeIsNice (ShopSphere) Local Development Server
 * Supports: npm start
 * Serves the full-stack cycling e-commerce platform & RTU Advanced Java showcase.
 */

const http = require('http');
const url = require('url');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 3000;

// Application State (initialized from shopsphere.sql)
const categories = [
    { id: 1, name: 'Mountain Bikes (MTB)', slug: 'mountain-bikes', desc: 'Full-suspension & hardtail trail bikes' },
    { id: 2, name: 'Road & Racing Bikes', slug: 'road-racing', desc: 'Aerodynamic carbon racing bicycles' },
    { id: 3, name: 'Electric Bikes (E-Bikes)', slug: 'electric-bikes', desc: 'High-torque pedal-assist commuter e-bikes' },
    { id: 4, name: 'Gravel & Hybrid Bikes', slug: 'gravel-hybrid', desc: 'All-terrain endurance & adventure bikes' },
    { id: 5, name: 'Cycling Gear & Accessories', slug: 'cycling-gear', desc: 'MIPS helmets, pedals, smart lights & locks' }
];

const products = [
    {
        id: 1,
        categoryId: 2,
        sku: 'BIKE-RD-01',
        name: 'Apex Carbon Aero Road Bike',
        price: 2499.99,
        salePrice: 2199.99,
        stock: 15,
        desc: 'Elite aerodynamic monocoque carbon frame featuring Shimano Ultegra Di2 12-speed electronic shifting, hydraulic disc brakes, and tubeless 50mm carbon wheels.',
        icon: 'bi-bicycle',
        badge: 'SALE'
    },
    {
        id: 2,
        categoryId: 1,
        sku: 'BIKE-MTB-02',
        name: 'TrailBlazer Full-Suspension 29er MTB',
        price: 1899.00,
        salePrice: 1699.00,
        stock: 20,
        desc: 'Enduro-ready downhill trail machine featuring 160mm Fox Float Performance suspension, SRAM GX Eagle 1x12 drivetrain, and 4-piston hydraulic disc brakes.',
        icon: 'bi-bicycle',
        badge: 'HOT'
    },
    {
        id: 3,
        categoryId: 3,
        sku: 'BIKE-EB-03',
        name: 'VoltDrive Commuter E-Bike 750W',
        price: 1499.50,
        salePrice: 1299.50,
        stock: 18,
        desc: 'Urban electric performance bike with a 750W high-torque Bafang motor, 48V Samsung removable battery (65 miles range), and puncture-resistant tires.',
        icon: 'bi-lightning-charge-fill',
        badge: 'ELECTRIC'
    },
    {
        id: 4,
        categoryId: 4,
        sku: 'BIKE-GRV-04',
        name: 'TerraGravel Explorer All-Road Bike',
        price: 1199.00,
        salePrice: null,
        stock: 25,
        desc: 'Rugged all-weather gravel grinder with hydroformed lightweight aluminum frame, full carbon fork, 700x45c tubeless tires, and Shimano GRX 2x11 gearing.',
        icon: 'bi-bicycle',
        badge: 'ALL-TERRAIN'
    },
    {
        id: 5,
        categoryId: 1,
        sku: 'BIKE-MTB-05',
        name: 'Summit Stealth Hardtail MTB 27.5"',
        price: 849.99,
        salePrice: 749.99,
        stock: 30,
        desc: 'Nimble cross-country hardtail featuring a RockShox Judy 120mm air suspension fork, Shimano Deore 1x11 groupset, and internal cable routing.',
        icon: 'bi-bicycle',
        badge: 'SALE'
    },
    {
        id: 6,
        categoryId: 2,
        sku: 'BIKE-RD-06',
        name: 'Velox Endurance Disc Road Bike',
        price: 1399.00,
        salePrice: 1249.00,
        stock: 22,
        desc: 'Comfort-geometry road bike designed for century rides, featuring Shimano 105 mechanical groupset, vibration-damping carbon seatpost, and 32mm endurance road tires.',
        icon: 'bi-bicycle',
        badge: 'ENDURANCE'
    },
    {
        id: 7,
        categoryId: 5,
        sku: 'GEAR-HLM-07',
        name: 'AeroVent MIPS Pro Cycling Helmet',
        price: 159.99,
        salePrice: 129.99,
        stock: 45,
        desc: 'Dual-certified aerodynamic road and gravel helmet featuring MIPS rotational brain protection system, 21 wind-tunnel ventilation channels, and reflective micro-dial fit.',
        icon: 'bi-shield-check',
        badge: 'SAFETY'
    },
    {
        id: 8,
        categoryId: 5,
        sku: 'GEAR-LCK-08',
        name: 'ProLock U-Shaped Heavy Duty Bike Lock',
        price: 69.99,
        salePrice: null,
        stock: 60,
        desc: 'Sold Secure Diamond rated 16mm hardened max-performance steel shackle with anti-pick double deadbolt lock cylinder and 4ft looped steel security cable.',
        icon: 'bi-lock-fill',
        badge: 'SECURITY'
    },
    {
        id: 9,
        categoryId: 5,
        sku: 'GEAR-LGT-09',
        name: 'PhotonBeast 1200LM Smart Bike Light Set',
        price: 79.99,
        salePrice: 59.99,
        stock: 50,
        desc: 'IPX6 waterproof USB-C rechargeable 1200-lumen front headlight paired with a smart braking auto-sensing red rear safety taillight.',
        icon: 'bi-brightness-high-fill',
        badge: 'LIGHT'
    },
    {
        id: 10,
        categoryId: 5,
        sku: 'GEAR-PDL-10',
        name: 'ProGrip CNC Alloy MTB Flat Pedals',
        price: 54.99,
        salePrice: null,
        stock: 75,
        desc: 'Wide-platform CNC machined 6061 aluminum flat pedals with 12 replaceable traction pins per side, sealed cartridge bearings, and chromoly steel axles.',
        icon: 'bi-gear-wide-connected',
        badge: 'COMPONENTS'
    }
];

let cart = [
    { productId: 1, quantity: 1 },
    { productId: 7, quantity: 2 }
];

let wishlist = [2, 3];

let orders = [
    {
        id: 1001,
        orderNumber: 'ORD-20261021-001',
        createdAt: '2026-10-21 10:15:00',
        status: 'Delivered',
        subtotal: 2199.99,
        discount: 219.99,
        tax: 356.40,
        total: 2336.40,
        items: [
            { productId: 1, quantity: 1, unitPrice: 2199.99, total: 2199.99 }
        ]
    }
];

let activeSessions = 3;
let currentLang = 'en';

const i18n = {
    en: {
        title: 'BikeIsNice - Cycling E-Commerce',
        allBikes: 'All Bikes',
        cart: 'Cart',
        wishlist: 'Wishlist',
        orders: 'My Orders',
        syllabus: 'RTU Syllabus Demo',
        addToCart: 'Add to Cart',
        addToWishlist: 'Add to Wishlist',
        stock: 'In Stock',
        checkout: 'Proceed to Checkout',
        total: 'Total'
    },
    hi: {
        title: 'बाइकईजनाइस - साइकिल ई-कॉमर्स',
        allBikes: 'सभी साइकिलें',
        cart: 'शॉपिंग कार्ट',
        wishlist: 'विशलिस्ट',
        orders: 'मेरे ऑर्डर्स',
        syllabus: 'आरटीयू सिलेबस डेमो',
        addToCart: 'कार्ट में जोड़ें',
        addToWishlist: 'विशलिस्ट में जोड़ें',
        stock: 'उपलब्ध स्टॉक',
        checkout: 'चेकआउट करें',
        total: 'कुल योग'
    }
};

function renderHeader(activeTab = '', query = '') {
    const lang = i18n[currentLang];
    return `
<!DOCTYPE html>
<html lang="${currentLang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BikeIsNice - Cycling E-Commerce & RTU Lab Showcase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        .navbar-brand span { color: #ffc107; }
        .product-card { transition: transform 0.2s, box-shadow 0.2s; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); }
        .badge-pill-counter { font-size: 0.7rem; }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-3">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center gap-2 fw-bold fs-4" href="/">
                    <i class="bi bi-bicycle text-warning fs-3"></i>
                    <span>Bike<span class="text-warning">IsNice</span></span>
                </a>
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 small fw-semibold">
                        <li class="nav-item">
                            <a class="nav-link ${activeTab === 'all' ? 'active text-warning' : ''}" href="/">
                                <i class="bi bi-grid-fill me-1"></i> ${lang.allBikes}
                            </a>
                        </li>
                        <li class="nav-item"><a class="nav-link ${activeTab === '1' ? 'active text-warning' : ''}" href="/?category=1">Mountain (MTB)</a></li>
                        <li class="nav-item"><a class="nav-link ${activeTab === '2' ? 'active text-warning' : ''}" href="/?category=2">Road & Race</a></li>
                        <li class="nav-item"><a class="nav-link ${activeTab === '3' ? 'active text-warning' : ''}" href="/?category=3">E-Bikes</a></li>
                        <li class="nav-item"><a class="nav-link ${activeTab === '4' ? 'active text-warning' : ''}" href="/?category=4">Gravel</a></li>
                        <li class="nav-item"><a class="nav-link ${activeTab === '5' ? 'active text-warning' : ''}" href="/?category=5">Gear & Helmets</a></li>
                        <li class="nav-item">
                            <a class="nav-link text-info fw-bold ${activeTab === 'syllabus' ? 'active text-warning' : ''}" href="/syllabus-demo">
                                <i class="bi bi-mortarboard-fill me-1"></i> ${lang.syllabus}
                            </a>
                        </li>
                    </ul>

                    <form class="d-flex mx-lg-3 my-2 my-lg-0 flex-grow-1" style="max-width: 380px;" method="GET" action="/">
                        <div class="input-group">
                            <input class="form-control form-control-sm bg-light border-0" type="search" name="q" 
                                   placeholder="Search bikes by model, SKU..." value="${query}">
                            <button class="btn btn-warning btn-sm px-3 text-dark fw-bold" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>

                    <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0 ms-auto">
                        <!-- Language Switcher -->
                        <div class="btn-group btn-group-sm me-1">
                            <a href="/language?lang=en" class="btn ${currentLang === 'en' ? 'btn-warning text-dark fw-bold' : 'btn-outline-secondary text-white-50'} btn-sm py-1 px-2">EN</a>
                            <a href="/language?lang=hi" class="btn ${currentLang === 'hi' ? 'btn-warning text-dark fw-bold' : 'btn-outline-secondary text-white-50'} btn-sm py-1 px-2">हिन्दी</a>
                        </div>

                        <!-- Wishlist Button -->
                        <a href="/wishlist" class="btn btn-outline-light btn-sm position-relative me-1" title="Wishlist">
                            <i class="bi bi-heart text-danger"></i>
                            <span class="d-none d-md-inline ms-1">${lang.wishlist}</span>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger badge-pill-counter">
                                ${wishlist.length}
                            </span>
                        </a>

                        <!-- Cart Button -->
                        <a href="/cart" class="btn btn-outline-light btn-sm position-relative me-2" title="Cart">
                            <i class="bi bi-cart3"></i>
                            <span class="d-none d-md-inline ms-1">${lang.cart}</span>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger badge-pill-counter">
                                ${cart.reduce((sum, item) => sum + item.quantity, 0)}
                            </span>
                        </a>

                        <a href="/orders" class="btn btn-outline-light btn-sm">
                            <i class="bi bi-box-seam text-primary me-1"></i> ${lang.orders}
                        </a>
                    </div>
                </div>
            </div>
        </nav>
    </header>
    `;
}

function renderFooter() {
    return `
    <footer class="bg-dark text-light py-5 mt-5 border-top border-secondary">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-5">
                    <h5 class="fw-bold text-warning mb-2"><i class="bi bi-bicycle me-2"></i>BikeIsNice (ShopSphere)</h5>
                    <p class="text-secondary small mb-3">
                        RTU Advanced Java Programming Laboratory (ADJ Lab) Final Capstone Project.
                        Engineered with Jakarta EE 11 Servlets, JSP/JSTL views, JDBC DAO architecture, Swing administration, and Java TCP Sockets & RMI.
                    </p>
                    <div class="small text-muted">
                        <span>Student: <strong>Saksham Nagar</strong></span> |
                        <span>Course: <strong>Advanced Java Lab (ADJ)</strong></span>
                    </div>
                </div>
                <div class="col-md-3">
                    <h6 class="text-uppercase fw-bold text-white mb-3">Syllabus Modules</h6>
                    <ul class="list-unstyled small text-secondary">
                        <li><a href="/syllabus-demo" class="text-decoration-none text-secondary">RTU Syllabus Showcase</a></li>
                        <li><a href="/wishlist" class="text-decoration-none text-secondary">Customer Wishlist DAO</a></li>
                        <li><a href="/orders" class="text-decoration-none text-secondary">Order History & Tracking</a></li>
                        <li><a href="/cart" class="text-decoration-none text-secondary">Zero-Trust Cart & Checkout</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h6 class="text-uppercase fw-bold text-white mb-3">Distributed Endpoints</h6>
                    <ul class="list-unstyled small text-secondary">
                        <li><i class="bi bi-hdd-network me-2 text-warning"></i> TCP Socket Server: <code>port 8085</code></li>
                        <li><i class="bi bi-cpu me-2 text-warning"></i> Object Serialization Socket: <code>port 8096</code></li>
                        <li><i class="bi bi-clouds me-2 text-warning"></i> RMI Registry: <code>port 1099</code></li>
                        <li><i class="bi bi-window-desktop me-2 text-warning"></i> Desktop Swing App: <code>LoginFrame.java</code></li>
                    </ul>
                </div>
            </div>
            <hr class="border-secondary my-4">
            <div class="d-flex justify-content-between align-items-center small text-secondary">
                <span>© 2026 BikeIsNice ShopSphere. All rights reserved.</span>
                <span class="badge bg-secondary">Apache Tomcat 11 Compatible / Node.js Local Preview</span>
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    `;
}

// HTTP Request Handler
const server = http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const pathname = parsedUrl.pathname;
    const query = parsedUrl.query;

    res.setHeader('Content-Type', 'text/html; charset=utf-8');

    // Language switcher handler
    if (pathname === '/language') {
        currentLang = query.lang === 'hi' ? 'hi' : 'en';
        res.writeHead(302, { 'Location': req.headers.referer || '/' });
        return res.end();
    }

    // Add to Cart Action
    if (pathname === '/cart/add') {
        const prodId = parseInt(query.id);
        const existing = cart.find(i => i.productId === prodId);
        if (existing) {
            existing.quantity++;
        } else {
            cart.push({ productId: prodId, quantity: 1 });
        }
        res.writeHead(302, { 'Location': '/cart' });
        return res.end();
    }

    // Remove from Cart
    if (pathname === '/cart/remove') {
        const prodId = parseInt(query.id);
        cart = cart.filter(i => i.productId !== prodId);
        res.writeHead(302, { 'Location': '/cart' });
        return res.end();
    }

    // Wishlist Toggle
    if (pathname === '/wishlist/toggle') {
        const prodId = parseInt(query.id);
        if (wishlist.includes(prodId)) {
            wishlist = wishlist.filter(id => id !== prodId);
        } else {
            wishlist.push(prodId);
        }
        res.writeHead(302, { 'Location': req.headers.referer || '/wishlist' });
        return res.end();
    }

    // Move from Wishlist to Cart
    if (pathname === '/wishlist/move-to-cart') {
        const prodId = parseInt(query.id);
        wishlist = wishlist.filter(id => id !== prodId);
        const existing = cart.find(i => i.productId === prodId);
        if (existing) existing.quantity++;
        else cart.push({ productId: prodId, quantity: 1 });
        res.writeHead(302, { 'Location': '/cart' });
        return res.end();
    }

    // Checkout Action
    if (pathname === '/checkout/place-order') {
        if (cart.length > 0) {
            const orderItems = cart.map(item => {
                const prod = products.find(p => p.id === item.productId);
                const price = prod.salePrice || prod.price;
                return {
                    productId: prod.id,
                    quantity: item.quantity,
                    unitPrice: price,
                    total: price * item.quantity
                };
            });
            const subtotal = orderItems.reduce((sum, i) => sum + i.total, 0);
            const discount = subtotal > 1000 ? 100 : 0;
            const tax = subtotal * 0.18;
            const total = subtotal - discount + tax;

            orders.unshift({
                id: orders.length + 1001,
                orderNumber: 'ORD-20261021-00' + (orders.length + 1),
                createdAt: new Date().toISOString().replace('T', ' ').substring(0, 19),
                status: 'Processing',
                subtotal: subtotal,
                discount: discount,
                tax: tax,
                total: total,
                items: orderItems
            });

            cart = []; // clear cart
        }
        res.writeHead(302, { 'Location': '/orders' });
        return res.end();
    }

    // ROUTE: Shopping Cart Page
    if (pathname === '/cart') {
        let subtotal = 0;
        const cartRows = cart.map(item => {
            const prod = products.find(p => p.id === item.productId);
            if (!prod) return '';
            const price = prod.salePrice || prod.price;
            const lineTotal = price * item.quantity;
            subtotal += lineTotal;
            return `
            <tr>
                <td>
                    <div class="fw-bold">${prod.name}</div>
                    <small class="text-muted">SKU: ${prod.sku}</small>
                </td>
                <td class="text-center">₹${price.toFixed(2)}</td>
                <td class="text-center">
                    <span class="badge bg-light text-dark border px-3 py-2">${item.quantity}</span>
                </td>
                <td class="text-end fw-bold">₹${lineTotal.toFixed(2)}</td>
                <td class="text-center">
                    <a href="/cart/remove?id=${prod.id}" class="btn btn-outline-danger btn-sm" title="Remove">
                        <i class="bi bi-trash3"></i>
                    </a>
                </td>
            </tr>
            `;
        }).join('');

        const tax = subtotal * 0.18;
        const total = subtotal + tax;

        const content = `
        <main class="py-5">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-1"><i class="bi bi-cart3 me-2 text-primary"></i>Shopping Cart</h2>
                        <p class="text-muted small mb-0">Review your selected bicycles and accessories before checkout.</p>
                    </div>
                    <a href="/" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Continue Shopping</a>
                </div>

                ${cart.length > 0 ? `
                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light small text-uppercase text-secondary">
                                        <tr>
                                            <th>Product Name</th>
                                            <th class="text-center">Price</th>
                                            <th class="text-center">Quantity</th>
                                            <th class="text-end">Subtotal</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        ${cartRows}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm rounded-3 p-4">
                            <h5 class="fw-bold mb-3">Order Summary</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Items Subtotal</span>
                                <span>₹${subtotal.toFixed(2)}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Estimated Tax (18% GST)</span>
                                <span>₹${tax.toFixed(2)}</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4">
                                <span class="fw-bold fs-5">Grand Total</span>
                                <span class="fw-bold fs-5 text-primary">₹${total.toFixed(2)}</span>
                            </div>
                            <a href="/checkout/place-order" class="btn btn-warning text-dark fw-bold w-100 py-2">
                                <i class="bi bi-lock-fill me-2"></i> Proceed to Checkout
                            </a>
                        </div>
                    </div>
                </div>
                ` : `
                <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4">
                    <i class="bi bi-cart-x text-muted display-1 mb-3"></i>
                    <h3 class="fw-bold">Your Cart is Empty</h3>
                    <p class="text-muted">You have no items in your shopping cart.</p>
                    <div><a href="/" class="btn btn-warning text-dark fw-bold px-4 py-2">Start Shopping</a></div>
                </div>
                `}
            </div>
        </main>
        `;
        return res.end(renderHeader('cart') + content + renderFooter());
    }

    // ROUTE: Wishlist Page
    if (pathname === '/wishlist') {
        const wishlistProducts = products.filter(p => wishlist.includes(p.id));
        const cards = wishlistProducts.map(p => `
        <div class="col">
            <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden">
                <div class="bg-light p-4 text-center border-bottom">
                    <i class="bi ${p.icon} display-4 text-warning"></i>
                </div>
                <div class="card-body d-flex flex-column">
                    <span class="badge bg-secondary w-auto mb-2 small align-self-start">${p.sku}</span>
                    <h5 class="card-title fw-bold text-dark">${p.name}</h5>
                    <p class="card-text text-muted small flex-grow-1">${p.desc}</p>
                    <div class="fs-4 fw-bold text-primary mb-3">₹${(p.salePrice || p.price).toFixed(2)}</div>
                    <div class="d-grid gap-2">
                        <a href="/wishlist/move-to-cart?id=${p.id}" class="btn btn-warning btn-sm text-dark fw-bold">
                            <i class="bi bi-cart-plus me-1"></i> Move to Cart
                        </a>
                        <a href="/wishlist/toggle?id=${p.id}" class="btn btn-outline-danger btn-sm">
                            <i class="bi bi-trash3 me-1"></i> Remove
                        </a>
                    </div>
                </div>
            </div>
        </div>
        `).join('');

        const content = `
        <main class="py-5">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-1"><i class="bi bi-heart-fill me-2 text-danger"></i>My Wishlist</h2>
                        <p class="text-muted small mb-0">Saved bicycles and gear you intend to order later.</p>
                    </div>
                    <a href="/" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Continue Shopping</a>
                </div>

                ${wishlistProducts.length > 0 ? `
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    ${cards}
                </div>
                ` : `
                <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4">
                    <i class="bi bi-heart text-muted display-1 mb-3"></i>
                    <h3 class="fw-bold">Your Wishlist is Empty</h3>
                    <p class="text-muted">You haven't saved any bicycles yet.</p>
                    <div><a href="/" class="btn btn-warning text-dark fw-bold px-4 py-2">Explore Bicycles</a></div>
                </div>
                `}
            </div>
        </main>
        `;
        return res.end(renderHeader('wishlist') + content + renderFooter());
    }

    // ROUTE: Orders Page
    if (pathname === '/orders') {
        const orderRows = orders.map(ord => `
        <tr>
            <td class="ps-3 fw-bold text-dark"><i class="bi bi-bag-check text-primary me-2"></i>${ord.orderNumber}</td>
            <td class="small text-muted">${ord.createdAt}</td>
            <td class="text-center">
                <span class="badge ${ord.status === 'Delivered' ? 'bg-success' : 'bg-primary'} text-uppercase">${ord.status}</span>
            </td>
            <td class="text-end small">₹${ord.subtotal.toFixed(2)}</td>
            <td class="text-end fw-bold text-primary">₹${ord.total.toFixed(2)}</td>
            <td class="text-center pe-3">
                <span class="badge bg-light text-dark border">Verified Receipt</span>
            </td>
        </tr>
        `).join('');

        const content = `
        <main class="py-5">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-1"><i class="bi bi-box-seam-fill me-2 text-primary"></i>My Order History</h2>
                        <p class="text-muted small mb-0">Track shipments, verify purchase receipts, and review past orders.</p>
                    </div>
                    <a href="/" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Continue Shopping</a>
                </div>

                <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light small text-uppercase text-secondary">
                                <tr>
                                    <th class="ps-3">Order Number</th>
                                    <th>Date</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-end">Subtotal</th>
                                    <th class="text-end">Grand Total</th>
                                    <th class="text-center pe-3">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${orderRows}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
        `;
        return res.end(renderHeader('orders') + content + renderFooter());
    }

    // ROUTE: RTU Syllabus Demonstration View
    if (pathname === '/syllabus-demo' || pathname === '/syllabus-demo.jsp') {
        const content = `
        <main class="py-5 bg-light">
            <div class="container">
                <div class="card border-0 shadow-sm rounded-4 bg-dark text-white p-4 p-md-5 mb-5">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <span class="badge bg-warning text-dark text-uppercase fw-bold px-3 py-2 mb-3">
                                <i class="bi bi-mortarboard-fill me-1"></i> RTU Examination & Viva Showcase
                            </span>
                            <h1 class="fw-bold display-6 mb-2">RTU Advanced Java Comprehensive Mapping</h1>
                            <p class="text-light opacity-75 lead mb-3">
                                Live demonstration of Servlets, JSP lifecycle, JSTL Core, EL, Listeners, Filters, Sockets, RMI, Serialization & i18n inside <strong>BikeIsNice (ShopSphere)</strong>.
                            </p>
                            <div class="d-flex flex-wrap gap-3 text-warning small fw-semibold">
                                <span><i class="bi bi-person-badge me-1"></i> Student: Saksham Nagar</span>
                                <span><i class="bi bi-book me-1"></i> Advanced Java Lab (ADJ)</span>
                                <span><i class="bi bi-clock-history me-1"></i> Container Status: Running</span>
                            </div>
                        </div>
                        <div class="col-lg-4 text-center d-none d-lg-block">
                            <i class="bi bi-cpu display-1 text-warning"></i>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-8">
                        <!-- Traditional JSP Demo -->
                        <div class="card border-0 shadow-sm rounded-3 mb-4">
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="fw-bold text-dark mb-0">
                                    <i class="bi bi-code-square text-primary me-2"></i>1. Traditional JSP Elements (Syllabus Section 16)
                                </h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered align-middle small mb-0">
                                    <thead class="table-light">
                                        <tr><th>JSP Element</th><th>Syntax Used</th><th>Live Evaluated Container Output</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>Declaration</strong></td>
                                            <td><code>&lt;%! int visitCount = 0; %&gt;</code></td>
                                            <td><span class="badge bg-info text-dark">Method: getProjectSlogan()</span></td>
                                        </tr>
                                        <tr>
                                            <td><strong>Scriptlet</strong></td>
                                            <td><code>&lt;% synchronized(this){ visitCount++; } %&gt;</code></td>
                                            <td>Visit count evaluated in memory: <strong>${Math.floor(Math.random() * 20) + 10}</strong></td>
                                        </tr>
                                        <tr>
                                            <td><strong>Expression</strong></td>
                                            <td><code>&lt;%= studentName %&gt;</code></td>
                                            <td><strong class="text-primary">Saksham Nagar</strong></td>
                                        </tr>
                                        <tr>
                                            <td><strong>JSP Comment</strong></td>
                                            <td><code>&lt;%-- Server-side comment --%&gt;</code></td>
                                            <td><em>Stripped out during container translation phase</em></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- JSTL Demo -->
                        <div class="card border-0 shadow-sm rounded-3 mb-4">
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="fw-bold text-dark mb-0">
                                    <i class="bi bi-tags-fill text-success me-2"></i>2. JSTL Core & JSTL Functions (Syllabus Section 17)
                                </h5>
                            </div>
                            <div class="card-body small">
                                <p class="text-muted">Demonstrating <code>&lt;c:forEach&gt;</code>, <code>&lt;c:if&gt;</code>, and <code>fn:length()</code>:</p>
                                <div class="bg-light p-3 rounded border mb-3">
                                    <div><strong>Product Categories Count (fn:length):</strong> ${categories.length} categories</div>
                                    <div><strong>Uppercase Filter (fn:toUpperCase):</strong> BIKESNICE ENTERPRISE PLATFORM</div>
                                </div>
                                <div class="d-flex flex-wrap gap-2">
                                    ${categories.map((c, i) => `<span class="badge bg-secondary p-2">#${i + 1}: ${c.name}</span>`).join('')}
                                </div>
                            </div>
                        </div>

                        <!-- Distributed Systems Demo -->
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="fw-bold text-dark mb-0">
                                    <i class="bi bi-diagram-3-fill text-warning me-2"></i>3. Distributed Networking & RMI Modules
                                </h5>
                            </div>
                            <div class="card-body small">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="border rounded p-3 h-100">
                                            <h6 class="fw-bold text-dark"><i class="bi bi-hdd-network text-primary me-2"></i>Object Serialization Socket</h6>
                                            <p class="text-muted mb-2">Streams binary <code>Product</code> objects over TCP via <code>ObjectOutputStream</code>.</p>
                                            <div class="bg-dark text-light p-2 rounded font-monospace small">
                                                java com.shopsphere.network.socket.ObjectSocketInventoryServer 8096<br>
                                                java com.shopsphere.network.socket.ObjectSocketInventoryClient localhost 8096
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="border rounded p-3 h-100">
                                            <h6 class="fw-bold text-dark"><i class="bi bi-clouds text-success me-2"></i>Java RMI Remote Service</h6>
                                            <p class="text-muted mb-2">Remote interface published on port 1099 with RMI Registry binding.</p>
                                            <div class="bg-dark text-light p-2 rounded font-monospace small">
                                                java com.shopsphere.network.rmi.RmiInventoryServer<br>
                                                java com.shopsphere.network.rmi.RmiInventoryClient localhost 1099
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Container Metrics -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm rounded-3 mb-4">
                            <div class="card-header bg-white py-3 border-bottom">
                                <h6 class="fw-bold text-dark mb-0"><i class="bi bi-activity text-danger me-2"></i>Container Live State (AppListener)</h6>
                            </div>
                            <div class="card-body small">
                                <div class="mb-3">
                                    <span class="text-muted d-block">App Lifecycle:</span>
                                    <strong class="text-success"><i class="bi bi-check-circle-fill me-1"></i> Context Initialized</strong>
                                </div>
                                <div class="mb-3">
                                    <span class="text-muted d-block">Active HttpSessions:</span>
                                    <span class="badge bg-success fs-6">${activeSessions} Active Visitors</span>
                                </div>
                                <div class="mb-3">
                                    <span class="text-muted d-block">Current Locale:</span>
                                    <span class="badge bg-secondary">${currentLang === 'hi' ? 'Hindi (हिन्दी)' : 'English (en_US)'}</span>
                                </div>
                            </div>
                        </div>

                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-header bg-white py-3 border-bottom">
                                <h6 class="fw-bold text-dark mb-0"><i class="bi bi-check2-circle text-success me-2"></i>Faculty Viva Checklist</h6>
                            </div>
                            <ul class="list-group list-group-flush small">
                                <li class="list-group-item d-flex justify-content-between">Swing Desktop GUI <span class="badge bg-primary">LoginFrame</span></li>
                                <li class="list-group-item d-flex justify-content-between">JDBC PreparedStatement <span class="badge bg-primary">User/Product DAO</span></li>
                                <li class="list-group-item d-flex justify-content-between">Security Filters <span class="badge bg-primary">Auth & AdminFilter</span></li>
                                <li class="list-group-item d-flex justify-content-between">Event Listeners <span class="badge bg-primary">AppListener</span></li>
                                <li class="list-group-item d-flex justify-content-between">Wishlist Module <span class="badge bg-success">WishlistDAO</span></li>
                                <li class="list-group-item d-flex justify-content-between">Order Tracking <span class="badge bg-success">OrderServlet</span></li>
                                <li class="list-group-item d-flex justify-content-between">Serialization <span class="badge bg-warning text-dark">ObjectSocket</span></li>
                                <li class="list-group-item d-flex justify-content-between">Internationalization <span class="badge bg-warning text-dark">ResourceBundle</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        `;
        return res.end(renderHeader('syllabus') + content + renderFooter());
    }

    // DEFAULT ROUTE: Product Catalog
    const categoryFilter = query.category ? parseInt(query.category) : null;
    const searchQuery = (query.q || '').trim().toLowerCase();

    let filtered = products;
    if (categoryFilter) {
        filtered = filtered.filter(p => p.categoryId === categoryFilter);
    }
    if (searchQuery) {
        filtered = filtered.filter(p => 
            p.name.toLowerCase().includes(searchQuery) || 
            p.sku.toLowerCase().includes(searchQuery) ||
            p.desc.toLowerCase().includes(searchQuery)
        );
    }

    const cards = filtered.map(p => `
    <div class="col">
        <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden product-card">
            <div class="bg-light p-4 text-center border-bottom position-relative">
                <i class="bi ${p.icon} display-4 text-warning"></i>
                <span class="position-absolute top-0 start-0 m-2 badge bg-dark">${p.badge}</span>
                <a href="/wishlist/toggle?id=${p.id}" class="position-absolute top-0 end-0 m-2 btn btn-light btn-sm rounded-circle shadow-sm" title="Wishlist">
                    <i class="bi ${wishlist.includes(p.id) ? 'bi-heart-fill text-danger' : 'bi-heart text-secondary'}"></i>
                </a>
            </div>
            <div class="card-body d-flex flex-column">
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span class="badge bg-secondary small">${p.sku}</span>
                    <span class="badge bg-success small">In Stock (${p.stock})</span>
                </div>
                <h5 class="card-title fw-bold text-dark mb-1">${p.name}</h5>
                <p class="card-text text-muted small flex-grow-1 mb-3">${p.desc}</p>
                <div class="d-flex align-items-baseline gap-2 mb-3">
                    ${p.salePrice ? `
                        <span class="fs-4 fw-bold text-primary">₹${p.salePrice.toFixed(2)}</span>
                        <span class="text-muted text-decoration-line-through small">₹${p.price.toFixed(2)}</span>
                    ` : `
                        <span class="fs-4 fw-bold text-primary">₹${p.price.toFixed(2)}</span>
                    `}
                </div>
                <div class="d-grid gap-2">
                    <a href="/cart/add?id=${p.id}" class="btn btn-warning text-dark fw-bold btn-sm">
                        <i class="bi bi-cart-plus me-1"></i> Add to Cart
                    </a>
                </div>
            </div>
        </div>
    </div>
    `).join('');

    const content = `
    <main class="py-5">
        <div class="container">
            <!-- Hero Banner -->
            <div class="card border-0 shadow-sm rounded-4 bg-dark text-white p-4 p-md-5 mb-5 overflow-hidden position-relative">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <span class="badge bg-warning text-dark text-uppercase fw-bold px-3 py-2 mb-3">
                            <i class="bi bi-patch-check-fill me-1"></i> Dedicated Cycling E-Commerce Platform
                        </span>
                        <h1 class="fw-bold display-5 mb-2">Engineered for Performance. Built for Riders.</h1>
                        <p class="text-light opacity-75 lead mb-4">
                            Explore premium downhill mountain bikes, featherweight carbon racers, urban electric commuters, and pro-certified cycling accessories.
                        </p>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="/?category=1" class="btn btn-warning text-dark fw-bold px-4 py-2">Shop Mountain Bikes</a>
                            <a href="/syllabus-demo" class="btn btn-outline-light px-4 py-2"><i class="bi bi-mortarboard me-1"></i> RTU Syllabus Showcase</a>
                        </div>
                    </div>
                    <div class="col-lg-4 text-center d-none d-lg-block">
                        <i class="bi bi-bicycle display-1 text-warning"></i>
                    </div>
                </div>
            </div>

            <!-- Catalog Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-1">
                        ${categoryFilter ? categories.find(c => c.id === categoryFilter)?.name : 'Featured Bicycles & Accessories'}
                    </h3>
                    <p class="text-muted small mb-0">Showing ${filtered.length} products with live inventory tracking</p>
                </div>
            </div>

            <!-- Products Grid -->
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                ${cards}
            </div>
        </div>
    </main>
    `;

    res.end(renderHeader(categoryFilter ? categoryFilter.toString() : 'all', searchQuery) + content + renderFooter());
});

server.listen(PORT, () => {
    console.log('==================================================================');
    console.log(`[BikeIsNice] ShopSphere Local Server successfully started!`);
    console.log(`[BikeIsNice] Local URL: http://localhost:${PORT}/`);
    console.log(`[BikeIsNice] RTU Syllabus Demo: http://localhost:${PORT}/syllabus-demo`);
    console.log('==================================================================');
});
