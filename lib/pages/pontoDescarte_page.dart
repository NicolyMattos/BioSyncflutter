import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PontoDescartePage extends StatefulWidget {
  const PontoDescartePage({super.key});

  static const String routePath = '/pontoDescarte';

  @override
  State<PontoDescartePage> createState() => _PontoDescartePageState();
}

class _PontoDescartePageState extends State<PontoDescartePage> {
  // Variáveis de Estado para os filtros
  String? _selectedCategory;
  String? _selectedDistance;

  // Opções de busca (Mock)
  static const List<String> _searchOptions = [
    'EcoPonto Central',
    'Reciclagem Verde',
    'Ponto de Coleta Sul',
    'Centro de Triagem',
    'Vidros Express'
  ];

  @override
  Widget build(BuildContext context) {
    // Cores do Design
    const Color primaryGreen = Color(0xFF50E18A);
    const Color drawerBackground = Color(0xFF171717);
    const Color darkText = Color(0xFF333333);

    return Scaffold(
      backgroundColor: primaryGreen, // Fundo Verde da Página
      
      // --- 1. MENU LATERAL (DRAWER) ---
      drawer: Drawer(
        backgroundColor: drawerBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cabeçalho do Drawer
            DrawerHeader(
              decoration: const BoxDecoration(color: drawerBackground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Simulado
                  Row(
                    children: [
                      Container(
                        width: 40, 
                        height: 40, 
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            // Imagem de placeholder igual ao original
                            image: NetworkImage('https://images.unsplash.com/photo-1617426841226-8373aab8e18f?w=100&q=80'),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'EcoApp',
                        style: GoogleFonts.interTight(
                          color: const Color(0xFFEEEEEE),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Itens do Menu
            _buildDrawerItem(
              icon: Icons.home_outlined,
              text: 'Home',
              // Navega para Login/Home (ajuste conforme sua preferência)
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            // Item Ativo (Destacado)
            Container(
              color: const Color(0xFF79C5D0).withOpacity(0.2), // Leve destaque azulado
              child: _buildDrawerItem(
                icon: Icons.business_outlined,
                text: 'Pontos de Descarte',
                textColor: const Color(0xFF79C5D0),
                iconColor: const Color(0xFF79C5D0),
                onTap: () => Navigator.pop(context), // Já estamos aqui
              ),
            ),
            _buildDrawerItem(
              icon: Icons.calendar_month_outlined,
              text: 'Agendamentos',
              onTap: () => Navigator.pushNamed(context, '/agendamento'),
            ),
            _buildDrawerItem(
              icon: Icons.settings_outlined,
              text: 'Configurações',
              onTap: () { /* Lógica de settings */ },
            ),
          ],
        ),
      ),

      // --- 2. BARRA SUPERIOR (APPBAR) ---
      appBar: AppBar(
        backgroundColor: primaryGreen,
        elevation: 0,
        // O ícone do menu (hambúrguer) aparece automaticamente quando há um Drawer
        iconTheme: const IconThemeData(color: darkText), 
        actions: [
          // Você pode adicionar actions extras aqui se quiser
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          )
        ],
      ),

      // --- 3. CORPO DA PÁGINA ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              // A. Barra de Busca (Autocomplete Nativo)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return _searchOptions.where((String option) {
                      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Buscar pontos de descarte...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    );
                  },
                  onSelected: (String selection) {
                    debugPrint('Selecionou: $selection');
                  },
                ),
              ),

              const SizedBox(height: 16),

              // B. Filtros (Dropdowns)
              Row(
                children: [
                  // Filtro Categoria
                  Expanded(
                    flex: 3,
                    child: _buildDropdownFilter(
                      hint: 'Categoria',
                      value: _selectedCategory,
                      items: ['Eletrônicos', 'Papel', 'Plástico', 'Metal', 'Vidro'],
                      onChanged: (val) => setState(() => _selectedCategory = val),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filtro Distância
                  Expanded(
                    flex: 2,
                    child: _buildDropdownFilter(
                      hint: 'Distância',
                      value: _selectedDistance,
                      items: ['1 km', '5 km', '10 km', '20 km'],
                      onChanged: (val) => setState(() => _selectedDistance = val),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // C. Mapa (Placeholder Visual)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map_outlined, size: 48, color: primaryGreen),
                    const SizedBox(height: 8),
                    Text(
                      'Mapa dos Pontos de Descarte',
                      style: GoogleFonts.interTight(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Visualize todos os pontos próximos a você',
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // D. Lista de Pontos (Cards)
              // Aqui usamos o Helper Method para evitar repetição
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDisposalCard(
                    title: 'EcoPonto Central',
                    address: 'Rua das Flores, 123 - Centro',
                    category: 'Eletrônicos',
                    distance: '1.2 km',
                    status: 'Aberto',
                    statusColor: primaryGreen,
                    icon: Icons.recycling,
                  ),
                  const SizedBox(height: 12),
                  _buildDisposalCard(
                    title: 'Reciclagem Verde',
                    address: 'Rua Limpa, 789 - Vila Verde',
                    category: 'Papel',
                    distance: '2.8 km',
                    status: 'Fechado',
                    statusColor: Colors.orange, // Cor de alerta
                    icon: Icons.delete_outline,
                  ),
                  const SizedBox(height: 12),
                  _buildDisposalCard(
                    title: 'Vidros Express',
                    address: 'Av. Transparente, 55 - Vidraçaria',
                    category: 'Vidro',
                    distance: '3.5 km',
                    status: 'Aberto',
                    statusColor: primaryGreen,
                    icon: Icons.wine_bar, // Ícone ilustrativo
                  ),
                ],
              ),
              
              // Espaço extra para o final da lista
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // --- MÉTODOS AUXILIARES (HELPERS) ---

  // 1. Construtor de Itens do Drawer
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color textColor = const Color(0xFFEEEEEE),
    Color iconColor = const Color(0xFFEEEEEE),
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: GoogleFonts.inter(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }

  // 2. Construtor de Dropdown de Filtro
  Widget _buildDropdownFilter({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Borda bem arredondada
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          isExpanded: true,
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: GoogleFonts.inter(fontSize: 14)),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // 3. Construtor do Card de Ponto de Descarte
  Widget _buildDisposalCard({
    required String title,
    required String address,
    required String category,
    required String distance,
    required String status,
    required Color statusColor,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Ícone Quadrado
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF50E18A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 12),
          // Textos e Detalhes
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.interTight(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Linha de Tags (Categoria, Distância, Status)
                Row(
                  children: [
                    _buildTag(category, const Color(0xFF50E18A)),
                    const SizedBox(width: 8),
                    _buildTag(distance, Colors.grey.shade400, textColor: Colors.black54),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: GoogleFonts.inter(
                            fontSize: 12, 
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 4. Helper para as "Etiquetas" (Chips pequenos)
  Widget _buildTag(String text, Color color, {Color textColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}