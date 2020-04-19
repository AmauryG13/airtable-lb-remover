import setuptools

with open('README.md', mode='r') as f:
    long_description = f.read()

setuptools.setup(
    name='Airtable-Export-Convertor',
    version='2.1.0',
    url='https://github.com/amauryg13/airtable-lb-remover.git',
    author='Amaury Guillermin',
    author_email='amauryguillermin@gmail.com',
    description='Script pour retirer les sauts de lignes dans un fichier CSV',
    long_description=long_description,
    long_description_content_type='text/markdown',
    scripts=['bin/airtable-convertor'],
    package_dir={'': 'src'},
    packages=setuptools.find_packages('src'),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3',
)
