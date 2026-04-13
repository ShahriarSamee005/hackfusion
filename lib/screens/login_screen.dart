import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/app_theme.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../widgets/widgets.dart';
import 'role_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey     = GlobalKey<FormState>();
  final _nameCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _passCtrl    = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _isLoginMode = true;
  bool _loading     = false;
  String? _error;
  String? _success;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String _generateOtp() {
    final rand = Random();
    return (1000 + rand.nextInt(9000)).toString();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
      _success = null;
    });

    try {
      if (_isLoginMode) {
        final user = await AuthService.login(
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text,
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => RoleSelectionScreen(
              name: user['name'] ?? '',
              email: user['email'] ?? '',
            ),
          ),
        );
      } else {
        // Generate OTP and show dialog before creating account
        setState(() => _loading = false);
        final otp = _generateOtp();
        if (!mounted) return;

        final verified = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) => _OtpDialog(
            otp: otp,
            email: _emailCtrl.text.trim(),
          ),
        );

        if (verified != true) return;

        // OTP verified — create account
        setState(() => _loading = true);
        final message = await AuthService.signup(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text,
        );
        if (!mounted) return;
        setState(() {
          _loading = false;
          _success = message;
          _isLoginMode = true;
          _nameCtrl.clear();
          _emailCtrl.clear();
          _passCtrl.clear();
          _confirmCtrl.clear();
        });
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Something went wrong. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 52),

                  // ── Logo ──────────────────────────────────
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.blue, AppColors.mint],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blue.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.bolt_rounded,
                        color: Colors.white, size: 44),
                  ),
                  const SizedBox(height: 20),

                  // ── Title ─────────────────────────────────
                  Text(
                    _isLoginMode ? 'Welcome back!' : 'Create account',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isLoginMode
                        ? 'Sign in to continue'
                        : 'Join the mesh network',
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 32),

                  // ── Success banner ────────────────────────
                  if (_success != null)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.success.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              size: 16, color: AppColors.success),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _success!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ── Error banner ──────────────────────────
                  if (_error != null)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.error.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline_rounded,
                              size: 16, color: AppColors.error),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ── Form ──────────────────────────────────
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_isLoginMode) ...[
                          AppTextField(
                            label: 'FULL NAME',
                            hint: 'Enter your full name',
                            controller: _nameCtrl,
                            prefixIcon: Icons.person_outline,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Name required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                        ],
                        AppTextField(
                          label: 'EMAIL',
                          hint: 'Enter your email',
                          controller: _emailCtrl,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Email required';
                            }
                            if (!v.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          label: 'PASSWORD',
                          hint: 'Enter your password',
                          controller: _passCtrl,
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Password required';
                            }
                            if (v.length < 6) {
                              return 'Min 6 characters';
                            }
                            return null;
                          },
                        ),
                        if (!_isLoginMode) ...[
                          const SizedBox(height: 14),
                          AppTextField(
                            label: 'CONFIRM PASSWORD',
                            hint: 'Re-enter your password',
                            controller: _confirmCtrl,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            validator: (v) {
                              if (v != _passCtrl.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Submit button ─────────────────────────
                  _loading
                      ? CircularProgressIndicator(
                          color: AppColors.blue.withOpacity(0.7),
                          strokeWidth: 2,
                        )
                      : PrimaryButton(
                          label: _isLoginMode ? 'Sign In' : 'Create Account',
                          icon: _isLoginMode
                              ? Icons.login_rounded
                              : Icons.person_add_outlined,
                          onTap: _submit,
                        ),
                  const SizedBox(height: 20),

                  // ── Toggle mode ───────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoginMode
                            ? "Don't have an account? "
                            : 'Already have an account? ',
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textMuted),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _isLoginMode = !_isLoginMode;
                          _error = null;
                          _success = null;
                        }),
                        child: Text(
                          _isLoginMode ? 'Sign Up' : 'Sign In',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blueDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── OTP Dialog ────────────────────────────────────────────────
class _OtpDialog extends StatefulWidget {
  final String otp;
  final String email;

  const _OtpDialog({required this.otp, required this.email});

  @override
  State<_OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<_OtpDialog> {
  final _otpCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  void _verify() {
    if (_otpCtrl.text.trim() == widget.otp) {
      Navigator.pop(context, true);
    } else {
      setState(() => _error = 'Incorrect OTP. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.verified_user_rounded,
                  color: AppColors.blueDark, size: 28),
            ),
            const SizedBox(height: 16),

            // Title
            const Text(
              'Verify Your Identity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Enter the OTP sent to\n${widget.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 20),

            // OTP display box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.blueDark.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.blueDark.withOpacity(0.25)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Your OTP Code',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.otp,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.blueDark,
                          letterSpacing: 8,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.otp));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('OTP copied'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Icon(Icons.copy_rounded,
                            size: 16, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // OTP input
            TextField(
              controller: _otpCtrl,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
                letterSpacing: 6,
              ),
              decoration: InputDecoration(
                counterText: '',
                hintText: '- - - -',
                hintStyle: const TextStyle(
                  color: AppColors.textMuted,
                  letterSpacing: 6,
                  fontSize: 20,
                ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.blue, width: 1.5),
                ),
              ),
              onChanged: (v) {
                if (_error != null) setState(() => _error = null);
                if (v.length == 4) _verify();
              },
            ),

            // Error
            if (_error != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.error_outline_rounded,
                      size: 14, color: AppColors.error),
                  const SizedBox(width: 6),
                  Text(
                    _error!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: _verify,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.blueDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
