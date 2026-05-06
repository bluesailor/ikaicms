<?php
/**
 * ikaiCMS - お問い合わせ（確認ステップ付き）
 */

declare(strict_types=1);

require_once __DIR__ . '/includes/init.php';

$channel = getChannelBySlug('contact');
$currentChannelId = $channel ? (int)$channel['id'] : 0;

$pageTitle = ($channel && $channel['seo_title']) ? $channel['seo_title'] : __('contact_title');
$pageKeywords = ($channel && $channel['seo_keywords']) ? $channel['seo_keywords'] : config('site_keywords');
$pageDescription = ($channel && $channel['seo_description']) ? $channel['seo_description'] : config('site_description');

$navChannels = getNavChannels();

// アイコンSVG
$iconPaths = [
    'phone'    => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>',
    'email'    => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>',
    'location' => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>',
    'clock'    => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>',
    'fax'      => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"></path>',
    'building' => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>',
    'globe'    => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9"></path>',
];

$contactCards = json_decode(config('contact_cards') ?: '[]', true) ?: [];
$gridCols = match (count($contactCards)) {
    1 => 'md:grid-cols-1',
    2 => 'md:grid-cols-2',
    4 => 'md:grid-cols-2 lg:grid-cols-4',
    default => 'md:grid-cols-3',
};

// フォームフィールド定義
$template = formTemplateModel()->findBySlug('contact');
$formFields = $template ? json_decode($template['fields'], true) : [];
$successMessage = $template['success_message'] ?? '送信が完了しました。';

require_once theme_path('layouts/header.php');
?>

<!-- ページヘッダー -->
<?php
$breadcrumbItems = [['name' => __('contact_title'), 'url' => '']];
if (!$channel) {
    $channel = ['name' => __('contact_title'), 'description' => __('contact_subtitle'), 'image' => ''];
}
require theme_path('partials/page-hero.php');
?>

<section class="py-12">
    <div class="container mx-auto px-4">
        <!-- 連絡先カード -->
        <?php if (!empty($contactCards)): ?>
        <div class="grid grid-cols-1 <?php echo $gridCols; ?> gap-6 mb-12">
            <?php foreach ($contactCards as $card): ?>
            <div class="bg-white rounded-lg shadow p-6 text-center">
                <?php if (!empty($card['icon']) && isset($iconPaths[$card['icon']])): ?>
                <div class="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <?php echo $iconPaths[$card['icon']]; ?>
                    </svg>
                </div>
                <?php endif; ?>
                <h3 class="font-bold text-dark mb-2"><?php echo e($card['label']); ?></h3>
                <p class="text-gray-600"><?php echo nl2br(e($card['value'])); ?></p>
            </div>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <!-- ステップインジケーター -->
        <div class="max-w-3xl mx-auto mb-8">
            <div class="flex items-center justify-center">
                <div class="flex items-center">
                    <div id="step-icon-1" class="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm">1</div>
                    <span id="step-label-1" class="ml-2 text-sm font-bold text-primary">入力</span>
                </div>
                <div class="w-16 md:w-24 h-0.5 bg-gray-200 mx-3"><div id="step-bar-1" class="h-full bg-gray-200 transition-all duration-300" style="width:0%"></div></div>
                <div class="flex items-center">
                    <div id="step-icon-2" class="w-10 h-10 rounded-full bg-gray-200 text-gray-400 flex items-center justify-center font-bold text-sm">2</div>
                    <span id="step-label-2" class="ml-2 text-sm text-gray-400">確認</span>
                </div>
                <div class="w-16 md:w-24 h-0.5 bg-gray-200 mx-3"><div id="step-bar-2" class="h-full bg-gray-200 transition-all duration-300" style="width:0%"></div></div>
                <div class="flex items-center">
                    <div id="step-icon-3" class="w-10 h-10 rounded-full bg-gray-200 text-gray-400 flex items-center justify-center font-bold text-sm">3</div>
                    <span id="step-label-3" class="ml-2 text-sm text-gray-400">完了</span>
                </div>
            </div>
        </div>

        <!-- フォーム本体 -->
        <div class="max-w-3xl mx-auto">
            <div class="bg-white rounded-lg shadow p-6 md:p-10">

                <!-- STEP 1: 入力 -->
                <div id="form-step-1">
                    <h2 class="text-xl font-bold text-dark mb-2"><?php echo e(config('contact_form_title') ?: __('contact_form_title')); ?></h2>
                    <?php if ($formDesc = config('contact_form_desc')): ?>
                    <p class="text-gray-500 text-sm mb-6"><?php echo e($formDesc); ?></p>
                    <?php else: ?>
                    <p class="text-gray-500 text-sm mb-6">以下のフォームにご記入の上、「確認画面へ」ボタンを押してください。<br><span class="text-red-500">*</span> は必須項目です。</p>
                    <?php endif; ?>

                    <form id="contact-form" novalidate>
                        <input type="hidden" name="form_slug" value="contact">
                        <table class="w-full">
                            <tbody>
                                <?php foreach ($formFields as $field):
                                    if (empty($field['key'])) continue;
                                    $key = $field['key'];
                                    $label = $field['label'] ?? $key;
                                    $type = $field['type'] ?? 'text';
                                    $required = !empty($field['required']);
                                    $placeholder = $field['placeholder'] ?? '';
                                ?>
                                <tr class="border-b border-gray-100">
                                    <th class="py-4 pr-4 text-sm font-bold text-gray-700 text-left align-top w-40 whitespace-nowrap">
                                        <?php echo e($label); ?>
                                        <?php if ($required): ?>
                                        <span class="inline-block ml-1 px-1.5 py-0.5 bg-red-500 text-white text-[10px] rounded leading-none align-middle">必須</span>
                                        <?php endif; ?>
                                    </th>
                                    <td class="py-4">
                                        <?php if ($type === 'textarea'): ?>
                                        <textarea name="<?php echo e($key); ?>" rows="5" placeholder="<?php echo e($placeholder); ?>"
                                            class="w-full border border-gray-300 rounded-lg px-4 py-3 text-sm contact-focus transition"
                                            <?php echo $required ? 'required' : ''; ?>></textarea>
                                        <?php else: ?>
                                        <input type="<?php echo e($type); ?>" name="<?php echo e($key); ?>" placeholder="<?php echo e($placeholder); ?>"
                                            class="w-full border border-gray-300 rounded-lg px-4 py-3 text-sm contact-focus transition"
                                            <?php echo $required ? 'required' : ''; ?>>
                                        <?php endif; ?>
                                        <p class="text-red-500 text-xs mt-1 hidden" id="err-<?php echo e($key); ?>"></p>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>

                        <div class="mt-4 p-4 bg-gray-50 rounded-lg text-xs text-gray-500 leading-relaxed">
                            <label class="flex items-start gap-2 cursor-pointer">
                                <input type="checkbox" id="privacy-agree" class="mt-0.5">
                                <span><a href="/privacy.html" target="_blank" class="text-primary underline">プライバシーポリシー</a>に同意の上、送信してください。</span>
                            </label>
                        </div>

                        <div class="mt-8 text-center">
                            <button type="button" onclick="goToConfirm()" class="bg-primary hover:bg-secondary text-white px-12 py-3.5 rounded-full font-bold text-sm transition contact-disabled">
                                確認画面へ
                            </button>
                        </div>
                    </form>
                </div>

                <!-- STEP 2: 確認 -->
                <div id="form-step-2" class="hidden">
                    <h2 class="text-xl font-bold text-dark mb-2">入力内容の確認</h2>
                    <p class="text-gray-500 text-sm mb-6">以下の内容でよろしければ「送信する」ボタンを押してください。</p>

                    <table class="w-full" id="confirm-table">
                        <tbody>
                            <?php foreach ($formFields as $field):
                                if (empty($field['key'])) continue;
                            ?>
                            <tr class="border-b border-gray-100">
                                <th class="py-4 pr-4 text-sm font-bold text-gray-700 text-left align-top w-40"><?php echo e($field['label'] ?? $field['key']); ?></th>
                                <td class="py-4 text-sm text-gray-800" id="confirm-<?php echo e($field['key']); ?>"></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>

                    <div class="mt-8 flex justify-center gap-4">
                        <button type="button" onclick="goBack()" class="border border-gray-300 text-gray-600 hover:bg-gray-50 px-10 py-3.5 rounded-full font-bold text-sm transition">
                            戻って修正する
                        </button>
                        <button type="button" id="submit-btn" onclick="submitForm()" class="bg-primary hover:bg-secondary text-white px-12 py-3.5 rounded-full font-bold text-sm transition contact-disabled">
                            送信する
                        </button>
                    </div>
                </div>

                <!-- STEP 3: 完了 -->
                <div id="form-step-3" class="hidden">
                    <div class="text-center py-8">
                        <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                            <svg class="w-10 h-10 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                        </div>
                        <h2 class="text-2xl font-bold text-dark mb-4">送信が完了しました</h2>
                        <p class="text-gray-500 mb-8"><?php echo e($successMessage); ?></p>
                        <a href="/" class="border border-gray-300 text-gray-600 hover:bg-gray-50 px-10 py-3.5 rounded-full font-bold text-sm transition">トップページへ戻る</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<script>
var formFields = <?php echo json_encode(array_map(fn($f) => ['key' => $f['key'], 'label' => $f['label'] ?? $f['key'], 'required' => !empty($f['required']), 'type' => $f['type'] ?? 'text'], $formFields)); ?>;

function setStep(n) {
    for (var i = 1; i <= 3; i++) {
        document.getElementById('form-step-' + i).classList.toggle('hidden', i !== n);
        var icon = document.getElementById('step-icon-' + i);
        var label = document.getElementById('step-label-' + i);
        if (i < n) {
            icon.className = 'w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm';
            icon.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>';
            label.className = 'ml-2 text-sm font-bold text-primary';
        } else if (i === n) {
            icon.className = 'w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm';
            icon.textContent = i;
            label.className = 'ml-2 text-sm font-bold text-primary';
        } else {
            icon.className = 'w-10 h-10 rounded-full bg-gray-200 text-gray-400 flex items-center justify-center font-bold text-sm';
            icon.textContent = i;
            label.className = 'ml-2 text-sm text-gray-400';
        }
    }
    if (n >= 2) document.getElementById('step-bar-1').style.width = '100%';
    else document.getElementById('step-bar-1').style.width = '0%';
    if (n >= 3) document.getElementById('step-bar-2').style.width = '100%';
    else document.getElementById('step-bar-2').style.width = '0%';
    window.scrollTo({top: 0, behavior: 'smooth'});
}

function goToConfirm() {
    var form = document.getElementById('contact-form');
    var ok = true;

    // バリデーション
    formFields.forEach(function(f) {
        var el = form.querySelector('[name="' + f.key + '"]');
        var errEl = document.getElementById('err-' + f.key);
        if (!el || !errEl) return;
        errEl.classList.add('hidden');
        el.classList.remove('border-red-400');
        var val = el.value.trim();

        if (f.required && val === '') {
            errEl.textContent = f.label + 'を入力してください';
            errEl.classList.remove('hidden');
            el.classList.add('border-red-400');
            ok = false;
        }
        if (f.type === 'email' && val !== '' && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
            errEl.textContent = 'メールアドレスの形式が正しくありません';
            errEl.classList.remove('hidden');
            el.classList.add('border-red-400');
            ok = false;
        }
    });

    if (!document.getElementById('privacy-agree').checked) {
        alert('プライバシーポリシーへの同意が必要です。');
        return;
    }

    if (!ok) return;

    // 確認画面へデータ反映
    formFields.forEach(function(f) {
        var el = form.querySelector('[name="' + f.key + '"]');
        var td = document.getElementById('confirm-' + f.key);
        if (el && td) {
            td.textContent = el.value || '—';
            if (f.type === 'textarea') td.style.whiteSpace = 'pre-wrap';
        }
    });

    setStep(2);
}

function goBack() {
    setStep(1);
}

function submitForm() {
    var btn = document.getElementById('submit-btn');
    btn.disabled = true;
    btn.textContent = '送信中...';

    var form = document.getElementById('contact-form');
    var fd = new FormData(form);

    fetch('/form_submit.php', {method: 'POST', body: fd})
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.code === 0) {
                setStep(3);
            } else {
                alert(data.msg || '送信に失敗しました。');
                btn.disabled = false;
                btn.textContent = '送信する';
            }
        })
        .catch(function() {
            alert('通信エラーが発生しました。もう一度お試しください。');
            btn.disabled = false;
            btn.textContent = '送信する';
        });
}
</script>

<?php require_once theme_path('layouts/footer.php'); ?>
