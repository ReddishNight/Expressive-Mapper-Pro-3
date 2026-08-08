import html
import os
import subprocess
import shutil

script_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(script_dir)

ascii_path = os.path.join(script_dir, 'ascii-art.txt')
if not os.path.exists(ascii_path):
    ascii_path = r'c:\Users\danny\Documents\Synthesizer V Scripts\ascii-art.txt'

with open(ascii_path, 'r', encoding='utf-8') as f:
    ascii_content = f.read()

escaped_ascii = html.escape(ascii_content)

raw_html_path = os.path.join(script_dir, 'manual_template_es_raw.html')
with open(raw_html_path, 'r', encoding='utf-8') as f:
    raw_html = f.read()

# Fórmulas y descripciones en español
f_pearson = "r = Sum((H(i) - H_prom) * (P(i) - P_prom)) / Sqrt[ Sum((H(i) - H_prom)^2 * Sum((P(i) - P_prom)^2) ]"
d_pearson = "Donde H(i) representa el histograma de notas ponderado por duración y métrica, y P(i) es el perfil de afinación ideal de Krumhansl-Kessler transpuesto a la tónica."
f_tcb_in = "V_incoming = [ (1 - T)*(1 - C)*(1 + B)*d1 + (1 - T)*(1 + C)*(1 - B)*d2 ] / 2"
f_tcb_out = "V_outgoing = [ (1 - T)*(1 + C)*(1 + B)*d1 + (1 - T)*(1 - C)*(1 - B)*d2 ] / 2"
f_gauss = "f(x) = (1 / (sigma * Sqrt(2 * pi))) * e^( - (x - mu)^2 / (2 * sigma^2) )"
d_gauss = "Donde la perturbación aleatoria normal (con media mu = 0 y desviación estándar sigma = antiFaseMs) se calcula usando la transformada de Box-Muller."
f_energy = "E_total = Sum [ P_nuevo(v) - P_previo(v) ]^2"
d_energy = "Donde P_nuevo(v) es el pitch absoluto de la voz v en la inversión candidata y P_previo(v) es el pitch de la voz correspondiente en el acorde anterior."

html_content = raw_html
html_content = html_content.replace('{escaped_ascii}', escaped_ascii)
html_content = html_content.replace('{formula_pearson}', f_pearson)
html_content = html_content.replace('{desc_pearson}', d_pearson)
html_content = html_content.replace('{formula_tcb_in}', f_tcb_in)
html_content = html_content.replace('{formula_tcb_out}', f_tcb_out)
html_content = html_content.replace('{formula_gauss}', f_gauss)
html_content = html_content.replace('{desc_gauss}', d_gauss)
html_content = html_content.replace('{formula_energy}', f_energy)
html_content = html_content.replace('{desc_energy}', d_energy)

output_path = os.path.join(script_dir, 'manual_template.html')
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(html_content)

print("manual_template.html generado exitosamente con todas las variables reemplazadas!")

# Compilar con Edge Headless a PDF
edge_path = r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
pdf_es_out = os.path.join(root_dir, 'Expressive_Mapper_Pro_3_Manual_ES.pdf')

print(f"Generating PDF: {pdf_es_out}")
try:
    subprocess.run([
        edge_path,
        '--headless',
        '--disable-gpu',
        '--no-pdf-header-footer',
        f'--print-to-pdf={pdf_es_out}',
        output_path
    ], check=True)
    print("¡PDF generado exitosamente!")
    
    # Desplegar copia a AppData
    appdata = os.environ.get('APPDATA', '')
    dest_dir = os.path.join(appdata, 'Dreamtonics', 'Synthesizer V Studio 2', 'scripts')
    if not os.path.exists(dest_dir):
        dest_dir = os.path.join(appdata, 'Dreamtonics', 'Synthesizer V Studio 2', 'scripts')
        
    dest = os.path.join(dest_dir, os.path.basename(pdf_es_out))
    print(f"Deploying to AppData: {dest}")
    shutil.copy2(pdf_es_out, dest)
except Exception as e:
    print(f"Error generando PDF o copiando a AppData: {e}")
