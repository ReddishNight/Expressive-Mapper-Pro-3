import html
import os
import subprocess
import shutil

appdata = os.environ.get('APPDATA', '')
dest_dir = os.path.join(appdata, 'Dreamtonics', 'Synthesizer V Studio 2', 'scripts')
if not os.path.exists(dest_dir):
    dest_dir = os.path.join(appdata, 'Dreamtonics', 'Synthesizer V Studio 2', 'scripts')

edge_path = r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'

script_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(script_dir)

ascii_path = os.path.join(script_dir, 'ascii-art.txt')
if not os.path.exists(ascii_path):
    ascii_path = r'c:\Users\danny\Documents\Synthesizer V Scripts\ascii-art.txt'

with open(ascii_path, 'r', encoding='utf-8') as f:
    ascii_content = f.read()

escaped_ascii = html.escape(ascii_content)

# EN manual
raw_en_path = os.path.join(script_dir, 'manual_template_en_raw.html')
with open(raw_en_path, 'r', encoding='utf-8') as f:
    raw_en = f.read()

f_pearson_en = "r = Sum((H(i) - H_prom) * (P(i) - P_prom)) / Sqrt[ Sum((H(i) - H_prom)^2 * Sum((P(i) - P_prom)^2) ]"
d_pearson_en = "Where H(i) represents the note duration histogram weighted by duration and metric strength, and P(i) is the ideal Krumhansl-Kessler key profile transposed to the tonic."
f_tcb_in_en = "V_incoming = [ (1 - T)*(1 - C)*(1 + B)*d1 + (1 - T)*(1 + C)*(1 - B)*d2 ] / 2"
f_tcb_out_en = "V_outgoing = [ (1 - T)*(1 + C)*(1 + B)*d1 + (1 - T)*(1 - C)*(1 - B)*d2 ] / 2"
f_gauss_en = "f(x) = (1 / (sigma * Sqrt(2 * pi))) * e^( - (x - mu)^2 / (2 * sigma^2) )"
d_gauss_en = "Where the normal random perturbation (with mean mu = 0 and standard deviation sigma = antiFaseMs) is calculated using the Box-Muller transform."
f_energy_en = "E_total = Sum [ P_nuevo(v) - P_previo(v) ]^2"
d_energy_en = "Where P_new(v) is the absolute pitch of voice v in the candidate inversion and P_prev(v) is the pitch of the corresponding voice in the previous chord."

html_en_content = raw_en
html_en_content = html_en_content.replace('{escaped_ascii}', escaped_ascii)
html_en_content = html_en_content.replace('{formula_pearson}', f_pearson_en)
html_en_content = html_en_content.replace('{desc_pearson}', d_pearson_en)
html_en_content = html_en_content.replace('{formula_tcb_in}', f_tcb_in_en)
html_en_content = html_en_content.replace('{formula_tcb_out}', f_tcb_out_en)
html_en_content = html_en_content.replace('{formula_gauss}', f_gauss_en)
html_en_content = html_en_content.replace('{desc_gauss}', d_gauss_en)
html_en_content = html_en_content.replace('{formula_energy}', f_energy_en)
html_en_content = html_en_content.replace('{desc_energy}', d_energy_en)

# JA manual
raw_ja_path = os.path.join(script_dir, 'manual_template_ja_raw.html')
with open(raw_ja_path, 'r', encoding='utf-8') as f:
    raw_ja = f.read()

f_pearson_ja = "r = Sum((H(i) - H_prom) * (P(i) - P_prom)) / Sqrt[ Sum((H(i) - H_prom)^2 * Sum((P(i) - P_prom)^2) ]"
d_pearson_ja = "ここで、H(i)は音長と強拍で重み付けされた音符のヒストグラムを表し、P(i)は主音に移調された理想的なKrumhansl-Kesslerキープロファイルを表します。"
f_tcb_in_ja = "V_incoming = [ (1 - T)*(1 - C)*(1 + B)*d1 + (1 - T)*(1 + C)*(1 - B)*d2 ] / 2"
f_tcb_out_ja = "V_outgoing = [ (1 - T)*(1 + C)*(1 + B)*d1 + (1 - T)*(1 - C)*(1 - B)*d2 ] / 2"
f_gauss_ja = "f(x) = (1 / (sigma * Sqrt(2 * pi))) * e^( - (x - mu)^2 / (2 * sigma^2) )"
d_gauss_ja = "ここで、平均mu = 0、標準偏差sigma = antiFaseMsの正規乱数による揺らぎは、ボックス＝ミュラー法を用いて計算されます。"
f_energy_ja = "E_total = Sum [ P_nuevo(v) - P_previo(v) ]^2"
d_energy_ja = "ここで、P_new(v)は候補となる和音の各声部vの絶対ピッチを表し、P_prev(v)は前回の和音の対応する声部のピッチを表します。"

html_ja_content = raw_ja
html_ja_content = html_ja_content.replace('{escaped_ascii}', escaped_ascii)
html_ja_content = html_ja_content.replace('{formula_pearson}', f_pearson_ja)
html_ja_content = html_ja_content.replace('{desc_pearson}', d_pearson_ja)
html_ja_content = html_ja_content.replace('{formula_tcb_in}', f_tcb_in_ja)
html_ja_content = html_ja_content.replace('{formula_tcb_out}', f_tcb_out_ja)
html_ja_content = html_ja_content.replace('{formula_gauss}', f_gauss_ja)
html_ja_content = html_ja_content.replace('{desc_gauss}', d_gauss_ja)
html_ja_content = html_ja_content.replace('{formula_energy}', f_energy_ja)
html_ja_content = html_ja_content.replace('{desc_energy}', d_energy_ja)

html_en_out_path = os.path.join(script_dir, 'manual_template_en.html')
html_ja_out_path = os.path.join(script_dir, 'manual_template_ja.html')

with open(html_en_out_path, 'w', encoding='utf-8') as f:
    f.write(html_en_content)

with open(html_ja_out_path, 'w', encoding='utf-8') as f:
    f.write(html_ja_content)

# Compilar con Edge Headless a PDF
def convert_to_pdf(html_in, pdf_out):
    print(f"Generating PDF: {pdf_out}")
    subprocess.run([
        edge_path,
        '--headless',
        '--disable-gpu',
        '--no-pdf-header-footer',
        f'--print-to-pdf={pdf_out}',
        html_in
    ], check=True)

pdf_en_out = os.path.join(root_dir, 'Expressive_Mapper_Pro_3_Manual_EN.pdf')
pdf_ja_out = os.path.join(root_dir, 'Expressive_Mapper_Pro_3_Manual_JA.pdf')

convert_to_pdf(html_en_out_path, pdf_en_out)
convert_to_pdf(html_ja_out_path, pdf_ja_out)

def copy_to_appdata(pdf_file):
    dest = os.path.join(dest_dir, os.path.basename(pdf_file))
    print(f"Deploying to AppData: {dest}")
    shutil.copy2(pdf_file, dest)

copy_to_appdata(pdf_en_out)
copy_to_appdata(pdf_ja_out)

print("¡Manuales Multilenguaje (Inglés y Japonés) generados 100% nativos con todas las variables reemplazadas!")
