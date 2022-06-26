import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/produtos.dart';
import '../models/produtos_list.dart';

class ProdutosFormPage extends StatefulWidget {
  const ProdutosFormPage({Key? key}) : super(key: key);

  @override
  _ProdutosFormPageState createState() => _ProdutosFormPageState();
}

class _ProdutosFormPageState extends State<ProdutosFormPage> {
  final _atacadoFocus = FocusNode();
  final _finalFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final produtos = arg as Produtos;
        _formData['id'] = produtos.id;
        _formData['nome_produto'] = produtos.nome_produto;
        _formData['descricao'] = produtos.descricao;
        _formData['preco_atacado'] = produtos.preco_atacado;
        _formData['preco_final'] = produtos.preco_final;
        _formData['urlImagem'] = produtos.urlImagem;

        _imageUrlController.text = produtos.urlImagem;
      }
    }
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProdutosList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _atacadoFocus.dispose();
    _finalFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = true;

    return isValidUrl && endsWithFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário de Produto'),
          actions: [
            IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: (_formData['nome_produto']?.toString()),
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_atacadoFocus);
                      },
                      onSaved: (name) => _formData['nome_produto'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: (_formData['preco_atacado']?.toString()),
                      decoration:
                          const InputDecoration(labelText: 'Preço Atacado'),
                      textInputAction: TextInputAction.next,
                      focusNode: _atacadoFocus,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (preco) => _formData['preco_atacado'] =
                          double.parse(preco ?? '0'),
                      validator: (_preco) {
                        final priceString = _preco ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: (_formData['preco_final']?.toString()),
                      decoration:
                          const InputDecoration(labelText: 'Preço Final'),
                      textInputAction: TextInputAction.next,
                      focusNode: _finalFocus,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (preco) =>
                          _formData['preco_final'] = double.parse(preco ?? '0'),
                      validator: (_preco) {
                        final priceString = _preco ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: (_formData['descricao']?.toString()),
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (descricao) =>
                          _formData['descricao'] = descricao ?? '',
                      validator: (_descricao) {
                        final descricao = _descricao ?? '';

                        if (descricao.trim().isEmpty) {
                          return 'Descrição é obrigatória';
                        }
                        if (descricao.trim().length < 10) {
                          return 'Descrição precisa ter no mínimo 10 letras.';
                        }

                        return null;
                      },
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Expanded(
                          child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Url da Imagem'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocus,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) => _submitForm(),
                        onSaved: (urlImagem) =>
                            _formData['urlImagem'] = urlImagem ?? '',
                        validator: (_urlImagem) {
                          final urlImagem = _urlImagem ?? '';
                          if (!isValidImageUrl(urlImagem)) {
                            return null; //'Informe uma Url válida!';
                          }
                          return null;
                        },
                      )),
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        alignment: Alignment.center,
                        child: _imageUrlController.text.isEmpty
                            ? const Text('Informe a Url')
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_imageUrlController.text)),
                      ),
                    ]),
                  ],
                ))));
  }
}
